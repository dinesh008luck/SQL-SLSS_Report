Use  [SLSS_DataLake];

--install access plugin - AccessDatabaseEngine_X64
 
   --run the below scripts in target db server
EXEC sp_configure 'show advanced options', 1
RECONFIGURE WITH OVERRIDE
GO
EXEC sp_configure 'ad hoc distributed queries', 1
RECONFIGURE WITH OVERRIDE
GO

--QuarterCD
--2023-24-Q1 (Apr, May Jun)
--2023-24-Q2 (Jul, Aug,Sep

EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
 
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO

---CALENDAR tables...
---POtential Table.. replica of Target Customers table

--insert and update -- [Customer ID] 
--Customer List Loading    ???????[Credit Limit] Cr is not inserting as value...need to in column name like [Credit Limit in INR]
INSERT INTO [dbo].[tbl_CustomerList]
([Branch Name],[Customer ID],[Customer Name],[Legal Name of Business],[Trade Name],[Group],[Contact Person],[Address-1],[Address-2],[Address-3],
[Country],[State],[Pin Code],[Phone],[Mobile No],[Email],[GST No],[Aadhar No],[PAN No],[Credit days],[Credit Limit in INR],[Location],[Sales Person],
[Customer Category],[Customer Type],[WhatsApp No],[District],[Taluka],[Potential],[Target],[DOB],[Anniversary],[Date of Creation],[Status],[Turn Over],[MSME No])

--[Customer ID] = "SLC"& PAN No   --- SLCANNPR7927F

SELECT DIstinct  [Branch Name],[Customer ID],[Customer Name],[Legal Name of Business],[Trade Name],[Group],[Contact Person],[Address-1],[Address-2],[Address-3],
[Country],[State],[Pin Code],[Phone],[Mobile No],[Email],[GST No],[Aadhar No],[PAN No],[Credit days],[Credit Limit in INR],[Location],[Sales Person],
[Customer Category],[Customer Type],[WhatsApp No],[District],[Taluka],[Potential],[Target],[DOB],[Anniversary],[Date of Creation],[Status],[Turn Over],[MSME No]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Customer List.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Customer List$]')

--ReceiptRegister   Loading       insert and update -- [Receipt Date],[Customer ID] 
INSERT INTO [dbo].[tbl_ReceiptRegister]
([Branch Name],[Receipt Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Voucher Type],[Voucher No],[Debit Amount],[Credit Amount]) 

SELECT DIstinct [Branch Name],[Receipt Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Voucher Type],[Voucher No],[Debit Amount],[Credit Amount]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Receipt Register.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Receipt Register$]')

--OutStandings Loading    --- evry month create a backup of data for history purpose  dbo].[tbl_OutStandingsHistory] add new column to identify MonthYears - August2023
INSERT INTO [dbo].[tbl_OutStandings]
([Branch Name],[Bill NO],[Bill Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Due Date],[Due Days],[Ageing],[Pending Amount]) 

SELECT DIstinct [Branch Name],[Bill NO],[Bill Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Due Date],[Due Days],[Ageing],[Pending Amount]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Outstandings.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Outstandings$]')

--TargetCustomers Loading        insert and update -- [Receipt Date],[Month], [Year]
--- evry Quarter create a backup of data for history purpose  dbo].[tbl_TargetCustomersHistory] add new column to identify MonthYears - August2023
INSERT INTO [dbo].[tbl_TargetCustomers]
([Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Target Qty],[Item Details],[Date],[Month],[Quarter],[Year]) 

SELECT  DIstinct [Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Target Qty],[Item Details],[Date],[Month],[Quarter],[Year]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Target Customers.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Target Customers$]')

--Potential Customers Loading        insert and update -- [Receipt Date],[Month], [Year]
--- evry Quarter create a backup of data for history purpose  dbo].[tbl_TargetCustomersHistory] add new column to identify MonthYears - August2023
INSERT INTO [dbo].[tbl_PotentialCustomers]
([Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Target Qty],[Item Details],[Date],[Month],[Quarter],[Year],[Potential Qty]) 

SELECT  DIstinct [Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Target Qty],[Item Details],[Date],[Month],[Quarter],[Year],[Potential Qty]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Potential Customers.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Potential Customers$]')

--Sales Vouchers Loading     appending the data 
INSERT INTO [dbo].[tbl_SalesVouchers]
([Branch Name],[Voucher Date],[Voucher No],[Customer Name],[Customer GSTNo],[PAN No],[Customer ID],[Group],[Product Name],[Godown Name],[Location]
,[Voucher Type],[Sales Person -1],[Sales Person -2],[Item Details],[Item Category],[Qty(MTs)],[Qty(Nos)],[Qty(Box)],[Qty(Pcs)],[Amount]) 

SELECT DIstinct 
[Branch Name],[Voucher Date],[Voucher No],[Customer Name],[Customer GSTNo],[PAN No],[Customer ID],[Group],[Product Name],[Godown Name],[Location]
,[Voucher Type],[Sales Person -1],[Sales Person -2],[Item Details],[Item Category],[Qty(MTs)],[Qty(Nos)],[Qty(Box)],[Qty(Pcs)],[Amount]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Sales Vouchers.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Sales Vouchers$]')

--SalesTeam Loading    
INSERT INTO [dbo].[tbl_SalesTeam]
([EMP ID],[Sales Person],[Team Name],[Reporting Manager],[Branch Name] )

SELECT DIstinct 
[EMP ID],[Sales Person],[Team Name],[Reporting Manager],[Branch Name] 
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Sales Team.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Sales Team$]')

--Items List Loading     
INSERT INTO [dbo].[tbl_ItemsList]
([Item Name] ,[Item Group],[Item Category],[Durastrong(Yes/No)] ) 

SELECT DIstinct 
[Item Name] ,[Item Group],[Item Category],[Durastrong(Yes/No)] 
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Items List.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Items List$]')

--Stock Details-CB Loading     
INSERT INTO [dbo].[tbl_StockDetails_CB] 
( [Branch Name] ,[Company Name] ,[Godown Name] ,[Item Details] ,[Qty] )

SELECT DIstinct 
 [Branch Name] ,[Company Name] ,[Godown Name] ,[Item Details] ,[Qty] 
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Stock Details-CB.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Stock Details-CB$]')

--Purchase Summary Loading     
INSERT INTO [dbo].[tbl_PurchaseSummary]
([Branch Name],[Purchase Date],[Creation Date],[Invoice No],[Voucher Type],[Vendor],[Godown Name],[Product Name],[Unit Of Measurement],[Actual Qty]
,[Billed Qty],[Actual Pcs],[Billed Pcs],[Difference Qty],[Rate],[Value],[Date Time]) 

SELECT DIstinct 
[Branch Name],[Purchase Date],[Creation Date],[Invoice No],[Voucher Type],[Vendor],[Godown Name],[Product Name],[Unit Of Measurement],[Actual Qty]
,[Billed Qty],[Actual Pcs],[Billed Pcs],[Difference Qty],[Rate],[Value],[Date Time]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Purchase Summary.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Purchase Summary$]')
 
 