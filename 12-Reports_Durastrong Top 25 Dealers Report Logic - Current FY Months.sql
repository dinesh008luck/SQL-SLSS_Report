Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales,#TempOutstandings,#TempCollectionAmount,#Months,#SNO,#SNO75,#FinalResult,#PotentialCustomers ;   

--select CAST(DATEADD(M, -3, GETDATE())-DATEPART(day, DATEADD(M, -3, GETDATE()))+1 as Date)   as Last3MonthStartDate
--select DATEADD(Month,1,getdate())-DATEPART(day, getdate())
 
--select CONCAT(YEAR(GETDATE())-1,'-',RIGHT(YEAR(GETDATE())+1,2)-1)   --Last FY

---Last FY Sales
;with CTELastFYSales AS
(
Select    distinct   
		SV.[Customer ID]
		--,SV.[Customer Name]  
		,SUM([Qty(MTs)]) as [Achv Qty] 
		--, CAST(SV.[Voucher Date] as date)
FROM [dbo].[tbl_SalesVouchers] SV WITH(Nolock)  
INNER JOIN [dbo].[tbl_Calendar] CAL  WITH(Nolock)
ON CAST(CAL.[CalendarDate] as Date) = CAST(SV.[Voucher Date] as date)    
Where   LEFT(CAL.[FiscalQuarter], 7) =  CONCAT(YEAR(GETDATE())-1,'-',RIGHT(YEAR(GETDATE())+1,2)-1)  --Last FY
 and SV.[Item Details] <> 'Welding Electrodes'
GROUP BY 
		SV.[Customer ID]
		--,SV.[Customer Name] 
--Order BY 1
)
Select   
		[Customer ID],
		--[Customer Name],
		ISNULL([Achv Qty], 0) as [Achv Qty],
		ROW_NUMBER() OVER (   ORDER BY [Achv Qty] Desc  ) SNO
Into #SNO
From CTELastFYSales
Order BY 3

--Top   Customers in last FY
Select  
	SNO,
	[Customer ID],
	--[Customer Name],
	[Achv Qty]  
Into #SNO75
From #SNO 
Order By SNO
  
---SalesTeam --  Customers
;with cteSales AS
(
Select     Distinct  
		ROW_NUMBER() OVER ( PARTITION BY SV.[Customer ID]  ORDER BY SV.[Voucher Date] Desc  ) ROW_NO,  
		SV.[Customer ID]
		,SV.[Customer Name] 
		,SV.[Customer GSTNo]  as GST
		,ST.[Team Name]  
		,SV.[Sales Person -2] as [Sales Person]
		,CAST(0  as Decimal(12,2)) as [Potential] ,
		CAST(0  as Decimal(12,2)) as [Target Qty],
		CAST(0  as Decimal(12,2)) as  [Achv Qty] ,
		CAST(0 as Decimal(12,2)) as  [Collection Target] ,
		CAST(0  as Decimal(12,2)) as  [Collection Achv] ,
		CAST(0  as Decimal(12,2)) as  [Pending Target] ,
		CAST(0  as Decimal(12,2)) as  [Daily Target] , 
		 CAST(0  as Decimal(12,2)) as Apr
		,CAST(0  as Decimal(12,2)) as May
		,CAST(0  as Decimal(12,2)) as Jun
		,CAST(0  as Decimal(12,2)) as Jul
		,CAST(0  as Decimal(12,2)) as Aug
		,CAST(0  as Decimal(12,2)) as Sep
		,CAST(0  as Decimal(12,2)) as Oct 
		,CAST(0  as Decimal(12,2)) as Nov
		,CAST(0  as Decimal(12,2)) as Dec
		,CAST(0  as Decimal(12,2)) as Jan
		,CAST(0  as Decimal(12,2)) as Feb
		,CAST(0  as Decimal(12,2)) as Mar 
FROM   [dbo].[tbl_SalesVouchers] SV WITH(Nolock)  
INNER JOIN  [dbo].[tbl_SalesTeam] ST WITH(Nolock)  
ON LTRIM(RTRIM(ST.[Sales Person])) = LTRIM(RTRIM(SV.[Sales Person -2]))
)
Select Distinct 
		[Customer ID]
		,[Customer Name] 
		,GST
		,[Team Name]  
		,[Sales Person]
		,[Potential] ,
		 [Target Qty],
		 [Achv Qty] , 
		 [Collection Achv] ,
		 [Pending Target] ,
		 [Daily Target] , 
		  Apr
		,May
		,Jun
		,Jul
		,Aug
		,Sep
		,Oct 
		,Nov
		,Dec
		,Jan
		,Feb
		,Mar  
Into #TempSalesTeam
From cteSales 
where ROW_NO=1
  
---TargetCustomers
Select   Distinct  
		--SV.[Team Name],
		--SV.[Sales Person],
		[Customer ID],
		ROUND(SUM(CAST(SV.[Target Qty] as Decimal(10,2))),2) as [Target Qty] 
		 --SV.[Date] 
Into #TargetCustomers 
From [dbo].[tbl_TargetCustomers] SV WITH(Nolock)   
Where  [Item Category] <> 'Welding Electrodes'
 and [Item Category] = 'DURASTRONG TMT' 
--and  YEAR(SV.[Date]) = YEAR(Getdate() )   and MONTH(SV.[Date]) = MONTH(Getdate() )  
GROUP BY 
		--SV.[Team Name],
		--SV.[Sales Person],
		[Customer ID] 
		--SV.[Date] 

---Sales
;WITH cteSales AS
(
Select      
		--ST.[Team Name],   
		--ST.[Sales Person],
		ST.[Customer ID] , 
		SUM([Qty(MTs)]) as [Achv Qty],
		TC.[MonthName] as [MonthName] ,
		MONTH(SV.[Voucher Date]) MonthNo,
		YEAR(SV.[Voucher Date]) YearNo
From #TempSalesTeam ST WITH(Nolock) 
INNER JOIN [dbo].[tbl_SalesVouchers] SV WITH(Nolock) 
ON LTRIM(RTRIM(SV.[Customer ID])) = LTRIM(RTRIM(ST.[Customer ID])) 
INNER JOIN [dbo].[tbl_Calendar] TC with(nolock) 
ON TC.[CalendarDate] = SV.[Voucher Date]
Where    ---YEAR(SV.[Voucher Date]) = YEAR(Getdate() ) 
--and SV.[Voucher Date] BETWEEN  CAST(DATEADD(M, -1, GETDATE())-DATEPART(day, DATEADD(M, -1, GETDATE()))+1 as Date) and CAST(GETDATE() as Date)
--YEAR(SV.[Voucher Date]) = YEAR(Getdate() )  and MONTH(SV.[Voucher Date]) = MONTH(Getdate() )  
LEFT(TC.[FiscalQuarter], 7)  = CONCAT(YEAR(GETDATE()) ,'-',RIGHT(YEAR(GETDATE())+1,2) )    --Current FY  
and [Item Details] <> 'Welding Electrodes'
 and [Item Details] = 'DURASTRONG TMT' 
GROUP BY 
		--ST.[Team Name],
		--ST.[Sales Person],
		ST.[Customer ID] , 
		TC.[MonthName] ,
		MONTH(SV.[Voucher Date]) ,
		YEAR(SV.[Voucher Date]) 
)
Select *  
Into #TempSales 
From cteSales  
   
Update ST
		Set ST.[Target Qty] = S.[Target Qty]  
From #TempSalesTeam ST
INNER JOIN #TargetCustomers S
ON S.[Customer ID] = ST.[Customer ID]


UPDATE ST
    SET  ST.Jan = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 1
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID]  

UPDATE ST
    SET  ST.Feb = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 2
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID] 

UPDATE ST
    SET  ST.Mar = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 3
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID]  

UPDATE ST
    SET  ST.Apr = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 4
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID]  

UPDATE ST
    SET  ST.May = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 5
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID]  

UPDATE ST
    SET  ST.Jun = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 6
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID]  

UPDATE ST
    SET  ST.Jul = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 7
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID]  

UPDATE ST
    SET  ST.Aug = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 8
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID] 

UPDATE ST
    SET  ST.Sep = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 9
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID]  

UPDATE ST
    SET  ST.Oct = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 10
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID] 

UPDATE ST
    SET  ST.Nov = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 11
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID]  

UPDATE ST
    SET  ST.Dec = ISNULL(S.[Achv Qty] ,0)
From #TempSalesTeam ST INNER JOIN 
(
 Select   
		[Customer ID] , 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		MonthNo 
 From #TempSales  CS
 Where MonthNo = 12
 Group By   
		[Customer ID],  
		MonthNo
    ) AS S 
ON  S.[Customer ID] = ST.[Customer ID]  
   
 ---Current Quarter Start/EndDates
Declare @StartDate Date, @EndDate Date;
Select @StartDate=CAST(MIN(CalendarDate) as Date)  ,   @EndDate=CAST(MAX(CalendarDate) as Date)   
FROM [dbo].[tbl_Calendar]  WITH(Nolock)   
where [FiscalQuarter] in (
		SELECT DIstinct  [FiscalQuarter] 
		FROM [dbo].[tbl_Calendar]  WITH(Nolock)   
		where LEFT([FiscalQuarter], 7) =CONCAT(YEAR(GETDATE()),'-',RIGHT(YEAR(GETDATE())+1,2))  and MONTH(CalendarDate) = MONTH(GETDATE()) 
)

--PotentialCustomers
SELECT  
       [Customer ID]
      ,[Customer Name] 
      ,CAST(SUM(CAST(ISNULL([Potential Qty],0) as Decimal(10,2))) as Int) as [Potential Qty]
Into #PotentialCustomers
FROM [dbo].[tbl_PotentialCustomers]   WITH(Nolock)  
Where CAST([Date] as Date)   BETWEEN @StartDate and @EndDate
 and [Item Details] = 'DURASTRONG TMT'
GROUP BY  [Customer ID]
,[Customer Name] 
 
Select   
		ROW_NUMBER() OVER (   ORDER BY SN.[Achv Qty] Desc  ) SNO,
		SN.[Customer ID]
		,st.[Customer Name] 
		,GST,
		[Team Name] as Team,
		[Sales Person] , 
		Potential,
		[Target Qty] ,   
		 Apr
		,May
		,Jun
		,Jul
		,Aug
		,Sep
		,Oct 
		,Nov
		,Dec
		,Jan
		,Feb
		,Mar 
INTO #FinalResult
From #SNO SN
LEFT JOIN  #TempSalesTeam st ON   st.[Customer ID] = SN.[Customer ID]
--Where [Team Name] is not null

--Update PotentialCustomers Qty
Update ST 
		Set ST.Potential = S.[Potential Qty]  
From #FinalResult ST																																																																																																													
INNER JOIN #PotentialCustomers S
ON S.[Customer ID] = ST.[Customer ID]  
  
Select --TOP 75
		SNO,
		CAST(Getdate()  as Date) as [Sales Date],
		DATENAME(month,GETDATE()) as [Month],
		YEAR(GETDATE()) as [Year],
		[Customer ID]
		,[Customer Name] 
		,GST,
		 Team,
		[Sales Person] , 
		Potential,
		[Target Qty] , 
		 Apr
		,May
		,Jun
		,Jul
		,Aug
		,Sep
		,Oct 
		,Nov
		,Dec
		,Jan
		,Feb
		,Mar 
From #FinalResult 
--Where [Customer ID] like '%8709%'
Order by SNO
 
Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales,#TempOutstandings,#TempCollectionAmount,#Months,#SNO,#SNO75,#FinalResult,#PotentialCustomers ;   