Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales,#TempOutstandings,#TempCollectionAmount,#Months,#TempSalesPreviousDate;

Select distinct TOP 2  MONTH([CalendarDate]) MonthNo, [MonthName]  
Into #Months
From  [dbo].[tbl_Calendar] TC with(nolock) 
where  YEAR([CalendarDate]) = YEAR(Getdate() ) and   MONTH([CalendarDate]) <= MONTH(Getdate() )    Order by 1 DESC
 
---SalesTeam
Select   Distinct  
		ST.[Team Name],    
		[Sales Person],  
		CAST(0  as Decimal(10,2)) as [Target Qty],
		CAST(0  as Decimal(10,2)) as  [Achv Qty] ,
		CAST(0  as Decimal(10,2)) as  [Collection Target] ,
		CAST(0  as Decimal(10,2)) as  [Collection Achv] ,
		CAST(0  as Decimal(10,2)) as  [Pending Target] ,
		CAST(0  as Decimal(10,2)) as  [Daily Target] ,
		CAST(Getdate()-18  as Date) as [Previous Date],   
		CAST(0  as Decimal(10,2)) as  [Current Month Achv] ,
		CAST(0  as Decimal(10,2)) as  [Previous Month Achv],
		 (Select TOP 1 [MonthName] From #Months Order by MonthNo Desc)  [Current Month],
		 (Select TOP 1 [MonthName] From #Months Order by MonthNo  )  [Previous Month] 
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
;WITH cteSales AS
(
Select      
		ST.[Team Name],   
		ST.[Sales Person],
		SUM([Qty(MTs)]) as [Achv Qty],
		TC.[MonthName] as [MonthName] ,
		MONTH(SV.[Voucher Date]) MonthNo,
		YEAR(SV.[Voucher Date]) YearNo
From #TempSalesTeam ST WITH(Nolock) 
INNER JOIN [dbo].[tbl_SalesVouchers] SV WITH(Nolock) 
ON LTRIM(RTRIM(SV.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person])) 
INNER JOIN [dbo].[tbl_Calendar] TC with(nolock) 
ON TC.[CalendarDate] = SV.[Voucher Date]
Where  --  YEAR(SV.[Voucher Date]) = YEAR(Getdate() )  and SV.[Voucher Date] BETWEEN  CAST(DATEADD(M, -1, GETDATE())-DATEPART(day, DATEADD(M, -1, GETDATE()))+1 as Date) and CAST(GETDATE() as Date)
  YEAR(SV.[Voucher Date]) = YEAR(Getdate() ) and MONTH(SV.[Voucher Date]) = MONTH(Getdate())  
 and SV.[Item Details] <> 'Welding Electrodes'
GROUP BY 
		ST.[Team Name],
		ST.[Sales Person],
		TC.[MonthName] ,
		MONTH(SV.[Voucher Date]) ,
		YEAR(SV.[Voucher Date]) 
)
Select *  Into #TempSales 
From cteSales where MonthNo in (Select TOP 2 MonthNo From cteSales Order by MonthNo Desc)  

---[Previous Date Qty]
;with CTESales AS 
(
 Select      
		ST.[Team Name],   
		ST.[Sales Person],
		ISNULL(SUM([Qty(MTs)] ) , 0) as [Achv Qty],
		SV.[Voucher Date] as [Sales Date] ,
		ST.[Previous Date] 
From #TempSalesTeam ST WITH(Nolock) 
LEFT JOIN [dbo].[tbl_SalesVouchers] SV WITH(Nolock) 
ON LTRIM(RTRIM(SV.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person])) 
and    YEAR(SV.[Voucher Date]) = YEAR(Getdate() ) and MONTH(SV.[Voucher Date]) = MONTH(Getdate())    
and CAST( SV.[Voucher Date]  as Date)  =  CAST(Getdate()-1 as Date)   --Previous Date
GROUP BY 
		ST.[Team Name],
		ST.[Sales Person],
		SV.[Voucher Date] ,
		ST.[Previous Date]
) 
Select 
		[Team Name],   
		[Sales Person],
		--SUM([Achv Qty] ) as [Achv Qty] ,    
		SUM(CAST([Achv Qty] as Decimal(10,2)))  as [Achv Qty] ,    
		[Sales Date] ,
		[Previous Date]
Into #TempSalesPreviousDate
From CTESales
Group BY
		[Team Name],   
		[Sales Person],
		[Sales Date] ,
		[Previous Date]

-----Collection  Amount 
--Select     
--		ST.[Team Name],  
--		ST.[Sales Person],
--		RR.[Receipt Date],
--		SUM(RR.[Credit Amount]) as [Collection  Amount] 
--Into #TempCollectionAmount 
--From #TempSalesTeam ST WITH(Nolock)  
--INNER JOIN [dbo].[tbl_ReceiptRegister] RR WITH(Nolock) 
--ON  LTRIM(RTRIM(RR.[Sales Person -1])) = LTRIM(RTRIM(ST.[Sales Person]))  
--Where  CAST(RR.[Receipt Date]  as Date) BETWEEN @WeekStartDayMonday and @WeekEndDaySaturday  -- Date week condition
--GROUP BY 
--		ST.[Team Name],
--		ST.[Sales Person],
--		RR.[Receipt Date] 

--Outstandings  get latest record data
;WITH cteOutstandings  AS
(
Select     
		ST.[Team Name],    
		ST.[Sales Person],
		SUM(OS.[Pending Amount]) as [Total  Outstanding],
		CASE WHEN OS.Ageing >25 THEN SUM(OS.[Pending Amount]) END as [Above 25 Days Outstanding] 
From #TempSalesTeam ST WITH(Nolock)  
INNER JOIN [dbo].[tbl_OutStandings] OS WITH(Nolock) 
ON  LTRIM(RTRIM(OS.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person]))  
Where CAST([Created Date] as Date) = (Select MAX(CAST([Created Date] as Date) ) From [dbo].[tbl_OutStandings] OS WITH(Nolock))  -- get latest record data
GROUP BY 
		ST.[Team Name], 
		ST.[Sales Person],
		OS.Ageing 
)
Select 
		[Team Name],
		[Sales Person],
		SUM([Total  Outstanding]) as [Total  Outstanding],
		SUM([Above 25 Days Outstanding]) as [Above 25 Days Outstanding] 
Into #TempOutstandings
From cteOutstandings
GROUP BY 
		[Team Name],
		[Sales Person]
		 
--Update ST
--		Set ST.[Achv Qty] = S.[Achv Qty] , ST.[Sales Date] = S.[Sales Date]
--From #TempSalesTeam ST
--INNER JOIN #TempSales S
--ON S.[Team Name] = ST.[Team Name]

--Update ST
--		Set ST.[Collection Achv] = S.[Collection  Amount]
--From #TempSalesTeam ST
--INNER JOIN #TempCollectionAmount S
--ON S.[Sales Person] = ST.[Sales Person]

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
 
---[Current Month Achv] 
Update ST 
		Set ST.[Achv Qty] = S.[Achv Qty]  , ST.[Current Month Achv] = S.[Achv Qty] 
From #TempSalesTeam ST
INNER JOIN #TempSales S
ON S.[Sales Person] = ST.[Sales Person] and S.MonthName = ST.[Current Month]

---[Previous Month Achv]
Update ST 
		Set ST.[Achv Qty] = S.[Achv Qty]  , ST.[Previous Month Achv] = S.[Achv Qty] 
From #TempSalesTeam ST
INNER JOIN #TempSales S
ON S.[Sales Person] = ST.[Sales Person] and S.MonthName = ST.[Previous Month]

--Working days count in current month
Declare @Workingdays as Int;
SELECT  @Workingdays=COUNT([CalendarDate])
FROM [dbo].[tbl_Calendar] with(nolock)
WHere [HolidayFlag] <> 'Y' and 
YEAR([CalendarDate]) = YEAR(Getdate() )  and 
MONTH([CalendarDate]) = MONTH(Getdate() )  and
CAST([CalendarDate]  as Date) >  CAST(Getdate()  as Date)

Select Distinct 
		CAST(Getdate()-1  as Date) as [Sales Date],
		DATENAME(month,GETDATE()) as [Month],
		YEAR(GETDATE()) as [Year],
		[Team Name] as Team,
		[Sales Person] as [Sales Men], 
		[Target Qty] as [Sales  Target], 		
		[Current Month Achv], 
		CAST(ISNULL((Select [Achv Qty] From #TempSalesPreviousDate s where s.[Sales Date] = st.[Previous Date] and s.[Team Name] = st.[Team Name] and s.[Sales Person] = st.[Sales Person]),0) as Decimal(10,2)) as [Previous Date Qty],
		ISNULL(ROUND(CAST([Current Month Achv] as float) / NULLIF(CAST([Target Qty] as float),0) *100 ,0),0)  as [Current Month Achv %], 
		[Previous Month Achv],
		[Collection Target] as [Above 25 Days Outstanding]
From #TempSalesTeam st
Where [Team Name] is not null
Order by 1 
 
Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales,#TempOutstandings,#TempCollectionAmount,#Months,#TempSalesPreviousDate;
 