Introduction

This document is used to understand how the customer data, item product group data, sales team structure data, and transactional data such as sales data, outstanding data, payment receipt data.etc is loaded into MS SQL database (SLSS_DataLake) server.  
Raw Data Tables are:

dbo.tbl_Calendar
dbo.tbl_CustomerList 
dbo.tbl_HierarchyMapping 
dbo.tbl_HierarchyMappingHistory 	
dbo.tbl_ItemsList	 	
dbo.tbl_OutStandings 
dbo.tbl_OutStandingsHistory 
dbo.tbl_PotentialCustomers	 
dbo.tbl_PurchaseSummary 
dbo.tbl_ReceiptRegister	 	
dbo.tbl_SalesTeam	 
dbo.tbl_SalesVouchers 
dbo.tbl_StockDetails_CB 	
dbo.tbl_TargetCustomers 
dbo.tbl_TargetCustomersHistory 


**Raw Data Tables loading stored procedures are:**

The following stored procedures are used to load the data into raw tables.
dbo.USP_SLSS_CustomerList_Table_Load 
dbo.USP_SLSS_HierarchyMapping_Table_Load 
dbo.USP_SLSS_ItemsList_Table_Load 
dbo.USP_SLSS_OutStandings_Table_Load 
dbo.USP_SLSS_OutStandingsHistory_Table_Load	 
dbo.USP_SLSS_PotentialCustomers_Table_Load 
dbo.USP_SLSS_PurchaseSummary_Table_Load 
dbo.USP_SLSS_ReceiptRegister_Table_Load	  
dbo.USP_SLSS_SalesTeam_Table_Load 
dbo.USP_SLSS_SalesVouchers_Table_Load	 
dbo.USP_SLSS_StockDetails_CB_Table_Load	 
dbo.USP_SLSS_TargetCustomers_Table_Load	 
dbo.USP_SLSS_TargetCustomersHistory_Table_Load 	
