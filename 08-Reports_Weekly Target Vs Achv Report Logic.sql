Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales,#TempOutstandings,#TempCollectionAmount

Declare @WeekStartDayMonday date, @WeekEndDaySaturday date ;

  SELECT  @WeekStartDayMonday=CAST(DATEADD(wk, DATEDIFF(wk,0,GETDATE()), 0) as Date)   ,   
  @WeekEndDaySaturday= CAST(DATEADD(WEEK, 1,  DATEADD(DAY, -1 * datepart(weekday, GETDATE()), GETDATE())) as Date) 
  --select  @WeekStartDayMonday , @WeekEndDaySaturday

---SalesTeam
Select   Distinct  
		ST.[Team Name],   
		[Sales Person],  
		CAST(0  as Decimal(12,2)) as [Target Qty],
		CAST(0  as Decimal(12,2)) as  [Achv Qty] ,
		CAST(0  as Decimal(12,2)) as  [Collection Target] ,
		CAST(0  as Decimal(12,2)) as  [Collection Achv] ,
		CAST(0  as Decimal(12,2)) as  [Pending Target] ,
		CAST(0  as Decimal(12,2)) as  [Daily Target] 
Into #TempSalesTeam
From [dbo].[tbl_SalesTeam] ST WITH(Nolock)  
Order BY 1

---TargetCustomers
Select   Distinct  
		SV.[Team Name],  
		SV.[Sales Person], 
		ROUND(SUM(CAST(SV.[Target Qty] as Decimal(10,2))),2) as [Target Qty], 
		 SV.[Date] 
Into #TargetCustomers 
From [dbo].[tbl_TargetCustomers] SV WITH(Nolock)   
Where  [Item Category] <> 'Welding Electrodes'
--and  YEAR(SV.[Date]) = YEAR(Getdate() )  and MONTH(SV.[Date]) = MONTH(Getdate() )  
GROUP BY 
		SV.[Team Name],
		SV.[Sales Person], 
		SV.[Date]  

---Sales
Select      
		ST.[Team Name],   
		ST.[Sales Person],
		 SUM([Qty(MTs)])as [Achv Qty] 
		--SV.[Voucher Date] as [Sales Date] 
Into #TempSales
From #TempSalesTeam ST WITH(Nolock) 
INNER JOIN [dbo].[tbl_SalesVouchers] SV WITH(Nolock) 
ON LTRIM(RTRIM(SV.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person])) 
Where    YEAR(SV.[Voucher Date]) = YEAR(Getdate() )  and MONTH(SV.[Voucher Date]) = MONTH(Getdate() ) 
 and SV.[Item Details] <> 'Welding Electrodes'
--CAST(SV.[Voucher Date]  as Date) BETWEEN @WeekStartDayMonday and @WeekEndDaySaturday  -- Date week condition
GROUP BY 
		ST.[Team Name],
		ST.[Sales Person] 
		--SV.[Voucher Date] 
Order by 1 
 
---Collection  Amount 
Select     
		ST.[Team Name],  
		ST.[Sales Person],
		RR.[Receipt Date],
		SUM(RR.[Credit Amount]) as [Collection  Amount] 
Into #TempCollectionAmount 
From #TempSalesTeam ST WITH(Nolock)  
INNER JOIN [dbo].[tbl_ReceiptRegister] RR WITH(Nolock) 
ON  LTRIM(RTRIM(RR.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person]))  
Where  CAST(RR.[Receipt Date]  as Date) BETWEEN @WeekStartDayMonday and @WeekEndDaySaturday  -- Date week condition
GROUP BY 
		ST.[Team Name],
		ST.[Sales Person],
		RR.[Receipt Date] 
		  
--Outstandings  get latest record data
;WITH cteOutstandings  AS
(
Select     
		--ST.[Team Name],    
		ST.[Sales Person],
		SUM(OS.[Pending Amount]) as [Total  Outstanding],
		CASE WHEN OS.Ageing >25 THEN SUM(OS.[Pending Amount]) END as [Above 25 Days Outstanding] 
From #TempSalesTeam ST WITH(Nolock)  
INNER JOIN [dbo].[tbl_OutStandings] OS WITH(Nolock) 
ON  LTRIM(RTRIM(OS.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person]))  
Where CAST([Created Date] as Date) = (Select MAX(CAST([Created Date] as Date) ) From [dbo].[tbl_OutStandings] OS WITH(Nolock))  -- get latest record data
GROUP BY 
		--ST.[Team Name], 
		ST.[Sales Person],
		OS.Ageing 
)
Select 
		--[Team Name],
		[Sales Person],
		SUM([Total  Outstanding]) as [Total  Outstanding],
		SUM([Above 25 Days Outstanding]) as [Above 25 Days Outstanding] 
Into #TempOutstandings
From cteOutstandings
GROUP BY 
		--[Team Name],
		[Sales Person]
 
Update ST
		Set ST.[Collection Achv] = S.[Collection  Amount]
From #TempSalesTeam ST
INNER JOIN #TempCollectionAmount S
ON S.[Sales Person] = ST.[Sales Person]

Update ST
		Set --ST.[Target Qty] = S.[Total  Outstanding] ,
			 ST.[Collection Target] = ISNULL(S.[Above 25 Days Outstanding],0) 
From #TempSalesTeam ST
INNER JOIN #TempOutstandings S
ON S.[Sales Person] = ST.[Sales Person]

Update ST
		Set ST.[Target Qty] = S.[Target Qty]  
From #TempSalesTeam ST
INNER JOIN #TargetCustomers S
ON S.[Sales Person] = ST.[Sales Person]

Update ST
		Set ST.[Achv Qty] = S.[Achv Qty]  
From #TempSalesTeam ST
INNER JOIN #TempSales S
ON S.[Sales Person] = ST.[Sales Person] and S.[Team Name] = ST.[Team Name]

--Working days count in current month
Declare @Workingdays as Int;
SELECT  @Workingdays=COUNT([CalendarDate])
FROM [dbo].[tbl_Calendar] with(nolock)
WHere [HolidayFlag] <> 'Y' and 
YEAR([CalendarDate]) = YEAR(Getdate() )  and 
MONTH([CalendarDate]) = MONTH(Getdate() ) and
CAST([CalendarDate]  as Date) >  CAST(Getdate()  as Date)  print @Workingdays

--Select @Workingdays

Select Distinct 
		CAST(Getdate()  as Date) as [Sales Date],
		DATENAME(month,GETDATE()) as [Month],
		YEAR(GETDATE()) as [Year],
		[Team Name] as Team,
		[Sales Person] as [Sales Men], 
		[Target Qty] as [Sales  Target],
		[Achv Qty]  as Achv,		
		ISNULL(ROUND(CAST([Achv Qty] as float) / NULLIF(CAST([Target Qty] as float),0) *100 ,0),0)  as [Achv %],	 
		CAST(( [Target Qty] - [Achv Qty] )  as Decimal(12,2)) as [Pending Target],
		CAST((( [Target Qty] - [Achv Qty] )/@Workingdays)  as Decimal(12,2))  as [Daily Target], 
		CAST((( [Target Qty] - [Achv Qty] )/@Workingdays)*6 as Decimal(12,2)) as [Weekly Target],  		
		[Collection Target],
		[Collection Achv] 
From #TempSalesTeam st
Where [Team Name] is not null
Order by 1 
 
Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales,#TempOutstandings,#TempCollectionAmount
 