 Drop Table IF Exists #TempSalesTeam,#TempCollectionAmount,#TempOutstandings,#TempSales;
 
 ---SalesTeam
Select   Distinct  
		ST.[Team Name],   
		[Sales Person],
		CAST(0  as Decimal(10,2)) as Sales,
		CAST(Getdate()  as Date) as [Sales Date],
		CAST(0  as Decimal(10,2)) as [Collection  Amount],
		CAST(0  as Decimal(18,2)) as [Total  Outstanding],
		CAST(0  as Decimal(18,2)) as [Above 25 Days Outstanding],
		CAST(0  as Decimal(18,2)) as [Above 45 Days Outstanding]
Into #TempSalesTeam
From [dbo].[tbl_SalesTeam] ST WITH(Nolock)  
Order BY 1

---Sales
Select   Distinct  
		ST.[Team Name],   
		SUM(SV.[Qty(MTs)]) as Sales,
		--SV.[Voucher Date] as [Sales Date],
		CAST(0  as Decimal(10,2)) as [Collection  Amount],
		CAST(0  as Decimal(10,2)) as [Total  Outstanding],
		CAST(0  as Decimal(10,2)) as [Above 25 Days Outstanding],
		CAST(0  as Decimal(10,2)) as [Above 45 Days Outstanding]
Into #TempSales
From #TempSalesTeam ST WITH(Nolock) 
INNER JOIN [dbo].[tbl_SalesVouchers] SV WITH(Nolock) 
ON LTRIM(RTRIM(SV.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person]))
INNER JOIN [dbo].[tbl_Calendar] TC with(nolock) 
ON TC.[CalendarDate] = SV.[Voucher Date]
Where   
YEAR(SV.[Voucher Date]) = YEAR(Getdate() ) and MONTH(SV.[Voucher Date]) = MONTH(Getdate())  
and  CAST(SV.[Voucher Date] as Date) =  CAST(Getdate()-1 as Date)   ---Yesterday 
--LEFT(TC.[FiscalQuarter], 7)  = CONCAT(YEAR(GETDATE()) ,'-',RIGHT(YEAR(GETDATE())+1,2) )    --Current FY  
and SV.[Item Details] <> 'Welding Electrodes'
GROUP BY 
		ST.[Team Name] 
		--,SV.[Voucher Date] 

---Collection  Amount 
Select     
		ST.[Team Name],   
		RR.[Receipt Date],
		SUM(RR.[Credit Amount]) as [Collection  Amount] 
Into #TempCollectionAmount 
From #TempSalesTeam ST WITH(Nolock)  
INNER JOIN [dbo].[tbl_ReceiptRegister] RR WITH(Nolock) 
ON  LTRIM(RTRIM(RR.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person]))  
Where CAST(RR.[Receipt Date] as Date) =  CAST(Getdate()-1 as Date)  ---Yesterday  
GROUP BY 
		ST.[Team Name],
		RR.[Receipt Date] 

--Outstandings  get latest record data
;WITH cteOutstandings  AS
(
Select     
		ST.[Team Name],    
		SUM(OS.[Pending Amount]) as [Total  Outstanding],
		CASE WHEN OS.Ageing >25 THEN SUM(OS.[Pending Amount]) END as [Above 25 Days Outstanding],
		CASE WHEN OS.Ageing >45 THEN SUM(OS.[Pending Amount]) END as [Above 45 Days Outstanding]
From #TempSalesTeam ST WITH(Nolock)  
INNER JOIN [dbo].[tbl_OutStandings] OS WITH(Nolock) 
ON  LTRIM(RTRIM(OS.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person]))  
Where CAST([Created Date] as Date) = (Select MAX(CAST([Created Date] as Date) ) From [dbo].[tbl_OutStandings] OS WITH(Nolock))  -- get latest record data
GROUP BY 
		ST.[Team Name], 
		OS.Ageing 
)
Select 
		[Team Name],
		SUM([Total  Outstanding]) as [Total  Outstanding],
		SUM([Above 25 Days Outstanding]) as [Above 25 Days Outstanding],
		SUM([Above 45 Days Outstanding]) as [Above 45 Days Outstanding]
Into #TempOutstandings
From cteOutstandings
GROUP BY 
		[Team Name]
		 
Update ST
		Set ST.Sales = S.Sales --, ST.[Sales Date] = S.[Sales Date]
From #TempSalesTeam ST
INNER JOIN #TempSales S
ON S.[Team Name] = ST.[Team Name]

Update ST
		Set ST.[Collection  Amount] = S.[Collection  Amount]
From #TempSalesTeam ST
INNER JOIN #TempCollectionAmount S
ON S.[Team Name] = ST.[Team Name]

Update ST
		Set  ST.[Total  Outstanding] = ISNULL(S.[Total  Outstanding],0.0)
			,ST.[Above 25 Days Outstanding] = ISNULL(S.[Above 25 Days Outstanding],0)
			,ST.[Above 45 Days Outstanding] = ISNULL(S.[Above 45 Days Outstanding],0)
From #TempSalesTeam ST
INNER JOIN #TempOutstandings S
ON S.[Team Name] = ST.[Team Name]
  
Select DIstinct 
		[Team Name],
		Sales,
		CAST(Getdate()-1  as Date) as [Sales Date],
		DATENAME(month,GETDATE()) as [Month],
		YEAR(GETDATE()) as [Year],
		[Collection  Amount],
		[Total  Outstanding],
		[Above 25 Days Outstanding],
		[Above 45 Days Outstanding]
From #TempSalesTeam 
Where [Team Name] is not null
 
Drop Table IF Exists #TempSalesTeam,#TempCollectionAmount,#TempOutstandings,#TempSales;

