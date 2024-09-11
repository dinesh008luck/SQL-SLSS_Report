Use SLSS_DataLake;

--TRuncate table [dbo].[tbl_CustomerList]
--TRuncate table [dbo].[tbl_ItemsList]
--TRuncate table [dbo].[tbl_OutStandings] 
--TRuncate table [dbo].[tbl_PotentialCustomers]
--TRuncate table [dbo].[tbl_PurchaseSummary]
--TRuncate table [dbo].[tbl_ReceiptRegister]
--TRuncate table [dbo].[tbl_SalesTeam]
--TRuncate table [dbo].[tbl_SalesVouchers]
--TRuncate table [dbo].[tbl_StockDetails_CB]
--TRuncate table [dbo].[tbl_TargetCustomers] 

EXEC [dbo].[USP_SLSS_CustomerList_Table_Load]
EXEC [dbo].[USP_SLSS_ItemsList_Table_Load]
EXEC [dbo].[USP_SLSS_OutStandings_Table_Load]
EXEC [dbo].[USP_SLSS_PotentialCustomers_Table_Load]
EXEC [dbo].[USP_SLSS_PurchaseSummary_Table_Load]
EXEC [dbo].[USP_SLSS_ReceiptRegister_Table_Load]
EXEC [dbo].[USP_SLSS_SalesTeam_Table_Load]
EXEC [dbo].[USP_SLSS_SalesVouchers_Table_Load]
EXEC [dbo].[USP_SLSS_StockDetails_CB_Table_Load]
EXEC [dbo].[USP_SLSS_TargetCustomers_Table_Load]
 