
Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales,#TempSalesPreviousDate;

---SalesTeam
Select   Distinct  
		ST.[Team Name],   
		[Sales Person], 
		CAST(Getdate() as Date) as [Date],
		CAST(0  as Decimal(10,2)) as  [Target Qty] ,  
		CAST(0  as Decimal(10,2)) as  [Achv Qty] ,
		CAST(Getdate()-2  as Date) as [Previous Date]
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
Where  [Item Category] <> 'Welding Electrodes'
--and  YEAR(SV.[Date]) = YEAR(Getdate() )  and MONTH(SV.[Date]) = MONTH(Getdate() )   
GROUP BY 
		SV.[Team Name],
		SV.[Date] 

---Sales
;with CTESales AS 
(
 Select      
		ST.[Team Name],   
		SUM([Qty(MTs)]) as [Achv Qty], 
		SV.[Voucher Date] as [Sales Date] ,
		ST.[Previous Date] 
From #TempSalesTeam ST WITH(Nolock) 
INNER JOIN [dbo].[tbl_SalesVouchers] SV WITH(Nolock) 
ON LTRIM(RTRIM(SV.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person])) 
and SV.[Item Details] <> 'Welding Electrodes'
and    YEAR(SV.[Voucher Date]) = YEAR(Getdate() ) and MONTH(SV.[Voucher Date]) = MONTH(Getdate())    
GROUP BY 
		ST.[Team Name],
		SV.[Voucher Date] ,
		ST.[Previous Date]
) 
Select 
		[Team Name],   
		SUM([Achv Qty] ) as [Achv Qty] ,   
		--SUM(CAST([Achv Qty] as Decimal(10,2)))  as [Achv Qty] ,  
		--[Sales Date] ,
		[Previous Date]
Into #TempSales
From CTESales
Group BY
		[Team Name],    
		--[Sales Date] ,
		[Previous Date]
 
Update ST
		Set ST.[Target Qty] = S.[Target Qty]  
From #TempSalesTeam ST
INNER JOIN #TargetCustomers S
ON S.[Team Name] = ST.[Team Name]
 
Update ST
		Set ST.[Achv Qty] = ISNULL(S.[Achv Qty],0) ,   
		ST.[Previous Date] = S.[Previous Date]
From #TempSalesTeam ST
INNER JOIN #TempSales S
ON S.[Team Name] = ST.[Team Name] 
 
---[Previous Date Qty]
;with CTESales AS 
(
 Select      
		ST.[Team Name],   
		SUM([Qty(MTs)] ) as [Achv Qty],
		SV.[Voucher Date] as [Sales Date] ,
		ST.[Previous Date] 
From #TempSalesTeam ST WITH(Nolock) 
LEFT JOIN [dbo].[tbl_SalesVouchers] SV WITH(Nolock) 
ON LTRIM(RTRIM(SV.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person])) 
and    YEAR(SV.[Voucher Date]) = YEAR(Getdate() ) and MONTH(SV.[Voucher Date]) = MONTH(Getdate())  
and CAST( SV.[Voucher Date]  as Date)  =  CAST(Getdate()-2  as Date)   --Previous Date
GROUP BY 
		ST.[Team Name],
		SV.[Voucher Date] ,
		ST.[Previous Date]
) 
Select 
		[Team Name],   
		--SUM([Achv Qty] ) as [Achv Qty] ,    
		SUM(CAST([Achv Qty] as Decimal(10,2)))  as [Achv Qty] ,    
		[Sales Date] ,
		[Previous Date]
Into #TempSalesPreviousDate
From CTESales
Group BY
		[Team Name],    
		[Sales Date] ,
		[Previous Date]
		  
Select Distinct 
		[Team Name],
		CAST(Getdate()  as Date) as [Sales Date],
		DATENAME(month,GETDATE()) as [Month],
		YEAR(GETDATE()) as [Year],
		[Target Qty],
		[Achv Qty],
		ISNULL(ROUND(CAST([Achv Qty] as float) / NULLIF(CAST([Target Qty] as float),0) *100 ,0),0)  as [Achv %] ,
		--[Previous Date],
		CAST(ISNULL((Select [Achv Qty] From #TempSalesPreviousDate s where s.[Sales Date] = st.[Previous Date] and s.[Team Name] = st.[Team Name]),0) as Decimal(10,2)) as [Previous Date Qty]		
From #TempSalesTeam st
Where [Team Name] is not null
 
Drop Table IF Exists #TargetCustomers,#TempSalesTeam,#TempSales,#TempSalesPreviousDate;