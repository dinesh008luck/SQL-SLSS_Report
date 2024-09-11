  
Drop Table IF Exists #SalesTeamCustomers,#TargetCustomers,#TempSales,#TempSaless,#CTESales;

---SalesTeam --  Customers
SELECT   --Distinct     
		[Branch Name]
		,[Team Name]
		,[Customer ID]
		,[Customer Name]
		,[GST No]  as GST 
		,[Sales Person]  
		,[Target Qty] as [Target For the Current Month]
		,[Item Category] 
		,CAST(0  as Decimal(12,2)) as Apr
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
Into #SalesTeamCustomers
FROM [dbo].[tbl_TargetCustomers]   WITH(Nolock)  
Where  [Item Category] <> 'Welding Electrodes'
--and  YEAR([Date]) = YEAR(Getdate() )  and MONTH([Date]) = MONTH(Getdate() )    
  --and [Customer ID]='SLCAACCK5360J'
  
---Sales 
Select   DIstinct   
		SV.*   
		,IL.[Item Category]   
		,MONTH(SV.[Voucher Date] ) as Month,
		Year(SV.[Voucher Date] ) as Year 
INto #CTESales
From   [dbo].[tbl_SalesVouchers] SV WITH(Nolock)  
INNER JOIN [dbo].[tbl_Calendar] TC  WITH(Nolock)
ON CAST(TC.[CalendarDate] as Date) = CAST(SV.[Voucher Date] as date) --and LEFT(TC.[FiscalQuarter], 7) = CONCAT(YEAR(GETDATE()),'-',RIGHT(YEAR(GETDATE())+1,2))
INNER JOIN dbo.tbl_ItemsList IL  WITH(Nolock)  
ON IL.[Item Details] = SV.[Item Details]
Where   
--CONCAT(YEAR(SV.[Voucher Date]),'-',RIGHT(YEAR(SV.[Voucher Date])+1,2))  =  CONCAT(YEAR(GETDATE()),'-',RIGHT(YEAR(GETDATE())+1,2)) and
SV.[Item Details] <> 'Welding Electrodes'
and LEFT(TC.[FiscalQuarter], 7)  = CONCAT(YEAR(GETDATE()) ,'-',RIGHT(YEAR(GETDATE())+1,2) )    --Current FY 
--and    YEAR(SV.[Voucher Date]) = YEAR(Getdate() ) and MONTH(SV.[Voucher Date]) = MONTH(Getdate())    
--and [Customer ID]='SLCAACCK5360J' 
 
 Select  
		[Sales Person -2]  as [Sales Person], 
		[Customer ID] ,
		[Item Category], 
		[Customer Name], 
		 SUM(CAST([Qty(MTs)] as Decimal(12,2)))   as [Achv Qty]  , 
		Month,
		Year
 Into #TempSaless
 From #CTESales CS
 Group By  
		[Sales Person -2] , 
		[Customer ID],
		[Item Category],
		[Customer Name], 
		Month,
		Year

 Select  
        [Sales Person], 
		[Customer ID] ,
		[Item Category], 
		[Customer Name], 
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty]  ,  
		Month,
		Year
 Into #TempSales
 From #TempSaless CS
 Group By  
		[Sales Person] , 
		[Customer ID],
		[Item Category],
		[Customer Name], 
		Month,
		Year
		  
--select * from #TempSales where Month=10 and [Customer ID]='SLCAACCK5360J'
--select * from #SalesTeamCustomers

UPDATE ST
    SET  ST.Jan = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 1
  
UPDATE ST
    SET  ST.Feb = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 2

UPDATE ST
    SET  ST.Mar = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 3

UPDATE ST
    SET  ST.Apr = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 4

UPDATE ST
    SET  ST.May = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 5

UPDATE ST
    SET  ST.Jun = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 6

UPDATE ST
    SET  ST.Jul = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 7

UPDATE ST
    SET  ST.Aug = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 8

UPDATE ST
    SET  ST.Sep = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 9

UPDATE ST
    SET  ST.Oct = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 10
  
UPDATE ST
    SET  ST.Nov = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 11

UPDATE ST
    SET  ST.Dec = S.[Achv Qty] 
From #SalesTeamCustomers ST INNER JOIN 
(
 Select   
		[Customer ID] ,
		[Item Category],  
		SUM(CAST([Achv Qty] as Decimal(12,2)))  as [Achv Qty] , 
		Month 
 From #TempSales  CS
 Group By   
		[Customer ID],
		[Item Category] , 
		Month
    ) AS S ON  S.[Item Category] = ST.[Item Category]  and
 S.[Customer ID] = ST.[Customer ID]   
and S.Month = 12
 
Select  -- distinct 
		CAST(Getdate()  as Date) as [Sales Date],
		DATENAME(month,GETDATE()) as [Month],
		YEAR(GETDATE()) as [Year],
		[Customer ID]
		,[Customer Name] 
		,[Item Category]
		,GST
		,[Team Name]
		,[Sales Person]
		,[Target For the Current Month]
		,Apr
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
From #SalesTeamCustomers 

Drop Table IF Exists #SalesTeamCustomers,#TargetCustomers,#TempSales,#TempSaless,#CTESales;