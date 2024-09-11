Drop Table IF Exists #StockDetails,#TargetCustomers,#TargetStockCustomers;

---Target vs StockCustomers
Select   Distinct  
		SV.[Team Name],  
		SV.[Item Category]  as [Product cluster], 
		CAST(Getdate() as Date) as [Date],
		ROUND(SUM(CAST(SV.[Target Qty] as Decimal(10,2))),2) as [Target Qty], 
		 CAST(0  as Decimal(10,2)) as Stock
Into #TargetStockCustomers 
From [dbo].[tbl_TargetCustomers] SV WITH(Nolock)   
Where  [Item Category] <> 'Welding Electrodes'
--and  YEAR(SV.[Date]) = YEAR(Getdate() )  and MONTH(SV.[Date]) = MONTH(Getdate() )   
GROUP BY 
		SV.[Team Name],
		SV.[Item Category] 

--StockDetails
SELECT   Distinct
		[Team Name] 
		,[Item Details] as [Product cluster] 
		,ISNULL(SUM(CAST([Qty] as Decimal(10,2))),0)   as Stock 
Into #StockDetails
FROM [dbo].[tbl_StockDetails_CB]  WITH(Nolock) 
Where CAST([Created Date] as Date) = (Select MAX(CAST([Created Date] as Date) ) From [dbo].[tbl_OutStandings] OS WITH(Nolock))  -- get latest record data
Group By [Team Name] 
		,[Item Details]  
 
Update ST
		Set ST.Stock = S.Stock  
From #TargetStockCustomers ST
INNER JOIN #StockDetails S
ON S.[Team Name] = ST.[Team Name] and S.[Product cluster] = ST.[Product cluster]

Select      
		CAST(Getdate()  as Date) as [Sales Date],
		DATENAME(month,GETDATE()) as [Month],
		YEAR(GETDATE()) as [Year],
		[Team Name] 
		,[Product cluster]
		,[Date]
		,[Target Qty]
		,Stock
From #TargetStockCustomers

UNION ALL 

Select 
		CAST(Getdate()  as Date) as [Sales Date],
		DATENAME(month,GETDATE()) as [Month],
		YEAR(GETDATE()) as [Year],
		[Team Name] 
		,[Product cluster]
		,CAST(Getdate() as Date) as [Date] 
		,0 as [Target Qty]
		,Stock
From
(
Select Distinct [Team Name] ,[Product cluster],Stock From #StockDetails
EXCEPT
Select Distinct [Team Name] ,[Product cluster],Stock From #TargetStockCustomers
)ah


Drop Table IF Exists #StockDetails,#TargetCustomers,#TargetStockCustomers;
 