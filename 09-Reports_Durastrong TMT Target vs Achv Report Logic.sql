Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales

---SalesTeam
Select   Distinct  
		ST.[Team Name],   
		[Sales Person], 
		CAST(Getdate()  as Date) as [Sales Date],
		CAST(0  as Decimal(10,2))  as [Target Qty],
		CAST(0  as Decimal(10,2))  as [Sales Achv] 
Into #TempSalesTeam
From [dbo].[tbl_SalesTeam] ST WITH(Nolock)  
Order BY 1

---TargetCustomers
Select   Distinct  
		SV.[Team Name],   
		ROUND(SUM(CAST(SV.[Target Qty] as Decimal(10,2))),2) as [Target Qty], 
		 SV.[Date] 
Into #TargetCustomers 
From [dbo].[tbl_TargetCustomers] SV WITH(Nolock)   
Where  [Item Category] = 'DURASTRONG TMT' 
and  [Item Category] <> 'Welding Electrodes'
--and  YEAR(SV.[Date]) = YEAR(Getdate() )  and MONTH(SV.[Date]) = MONTH(Getdate() )   
GROUP BY 
		SV.[Team Name], 
		SV.[Date]  
		  
---Sales
;with CTESales AS
(
Select      
		ST.[Team Name],   
		SUM([Qty(MTs)]) as [Sales Achv],
		SV.[Voucher Date] as [Sales Date] 
From #TempSalesTeam ST WITH(Nolock) 
INNER JOIN [dbo].[tbl_SalesVouchers] SV WITH(Nolock) 
ON LTRIM(RTRIM(SV.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person]))
Where SV.[Item Details] = 'DURASTRONG TMT'
and    YEAR(SV.[Voucher Date]) = YEAR(Getdate() ) and MONTH(SV.[Voucher Date]) = MONTH(Getdate())     
GROUP BY 
		ST.[Team Name],
		SV.[Voucher Date] 
)
Select 
		[Team Name],
		SUM([Sales Achv]) as [Sales Achv] 
Into #TempSales
From CTESales
GROUP BY 
		[Team Name] 

Update ST
		Set ST.[Target Qty] = S.[Target Qty]  
From #TempSalesTeam ST
INNER JOIN #TargetCustomers S
ON S.[Team Name] = ST.[Team Name]
 
Update ST
		Set ST.[Sales Achv] = S.[Sales Achv]  
From #TempSalesTeam ST
INNER JOIN #TempSales S
ON S.[Team Name] = ST.[Team Name]

Select Distinct 
		[Team Name],
		CAST(Getdate()  as Date) as [Sales Date],
		DATENAME(month,GETDATE()) as [Month],
		YEAR(GETDATE()) as [Year],
		[Target Qty],
		[Sales Achv]  
		,ISNULL(ROUND(CAST([Sales Achv] as float) / NULLIF(CAST([Target Qty] as float),0) *100 ,0),0)  as [Achv %] 
From #TempSalesTeam
Where [Team Name] is not null

Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales