Drop Table IF Exists #TargetCustomers,#SalesReportFinal,#tbl_ItemsList,#Sales,#SalesTemp;

---TargetCustomers
Select     
		SV.[Team Name],  
		SV.[Sales Person],
		SV.[Item Category]  as [Product cluster], 
		ROUND(SUM(CAST(SV.[Target Qty] as Decimal(10,2))),2) as [Target Qty], 
		 SV.[Date] 
Into #TargetCustomers 
From [dbo].[tbl_TargetCustomers] SV WITH(Nolock)   
Where  [Item Category] = 'Welding Electrodes'
--and  YEAR(SV.[Date]) = YEAR(Getdate() )  and MONTH(SV.[Date]) = MONTH(Getdate() )   
GROUP BY 
		SV.[Team Name],
		SV.[Sales Person],
		SV.[Item Category],
		SV.[Date] 
 	
---Sales 
Select          
		ST.[Team Name],   
		ST.[Sales Person],
		IL.[Item Category] as [Product cluster],
		CAST(0  as Decimal(10,2)) as [Target Qty],
		--CASE WHEN SV.[Item Details] = 'Welding Electrodes' THEN  SUM([Qty(Box)]) Else SUM([Qty(MTs)])  End as [Achv Qty],
		CASE WHEN SV.[Item Details] = 'Welding Electrodes' THEN  SUM([Qty(Box)])  End as [Achv Qty],
		Format(SV.[Voucher Date],'MMMM') as [MonthName] , 
		YEAR(SV.[Voucher Date]) YearNo 
INTO #SalesTemp
From [dbo].[tbl_SalesTeam] ST WITH(Nolock)  
INNER JOIN [dbo].[tbl_SalesVouchers] SV WITH(Nolock) 
ON LTRIM(RTRIM(SV.[Sales Person -2])) = LTRIM(RTRIM(ST.[Sales Person]))  
INNER JOIN (Select Distinct
		[Item Details],
		[Item Category] 
From dbo.tbl_ItemsList IL  WITH(Nolock) ) IL   
ON IL.[Item Details] = SV.[Item Details]  
Where    YEAR(SV.[Voucher Date]) = YEAR(Getdate() ) and MONTH(SV.[Voucher Date]) = MONTH(Getdate())   
and SV.[Item Details] = 'Welding Electrodes' 
GROUP BY 
		ST.[Team Name], 
		ST.[Sales Person],
		SV.[Voucher Date],  
		SV.[Item Details],
		IL.[Item Category] 

Select * 
INTO #Sales
FROM
(
Select 
		[Team Name], 
		[Sales Person],
		[Product cluster],
		[Target Qty], 
		 SUM([Achv Qty]) as [Achv Qty],
		 [MonthName] , 
		 YearNo
From #SalesTemp
Group By 
		[Team Name], 
		[Sales Person],
		[Product cluster],
		[Target Qty],  
		 [MonthName] , 
		 YearNo

UNION ALL

Select          
		TC.[Team Name],   
		TC.[Sales Person],
		TC.[Product cluster],
		TC.[Target Qty], 
		CAST(0  as Decimal(10,2)) as [Achv Qty],
		NULL as [MonthName] , 
		NULL as YearNo
From #TargetCustomers TC
INNER JOIN (
Select Distinct [Team Name],   [Product cluster] ,[Sales Person] From #TargetCustomers
EXCEPT
Select Distinct [Team Name],   [Product cluster] ,[Sales Person]  From #SalesTemp
)ah
ON ah.[Team Name] = TC.[Team Name] and ah.[Product cluster] = TC.[Product cluster] and ah.[Sales Person] = TC.[Sales Person]
)ap

Select 
	[Team Name],  
	[Sales Person],
	[Product cluster],
	[Target Qty],
	SUM([Achv Qty])    as [Achv Qty],
	[MonthName] , 
	YearNo
Into #SalesReportFinal
From #Sales
Group By
[Team Name],   
[Sales Person],
[Product cluster],
[Target Qty], 
[MonthName] , 
YearNo
 
Update ST
		Set ST.[Target Qty] = S.[Target Qty]  
From #SalesReportFinal ST
INNER JOIN #TargetCustomers S
ON LTRIM(RTRIM(S.[Team Name])) = LTRIM(RTRIM(ST.[Team Name]))  and LTRIM(RTRIM(S.[Product cluster])) = LTRIM(RTRIM(ST.[Product cluster]))
and LTRIM(RTRIM(S.[Sales Person])) = LTRIM(RTRIM(ST.[Sales Person]))

Select    
		CAST(Getdate()  as Date) as [Sales Date], 
		[Team Name],    
		[Sales Person],
		[Product cluster],
		[Target Qty],
		 [Achv Qty],
		 ISNULL(ROUND(CAST([Achv Qty] as float) / NULLIF(CAST([Target Qty] as float),0) *100 ,0),0)  as [Achv %] ,
		MAX([MonthName]) OVER (PARTITION BY [Team Name] ) as [MonthName] , 
		MAX(YearNo) OVER (PARTITION BY [Team Name] ) as YearNo
From #SalesReportFinal 

Drop Table IF Exists #TargetCustomers,#SalesReportFinal,#tbl_ItemsList,#Sales,#SalesTemp;
 