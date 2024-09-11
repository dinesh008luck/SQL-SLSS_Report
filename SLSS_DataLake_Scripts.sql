USE [SLSS_DataLake]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_TargetCustomersHistory_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_TargetCustomersHistory_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_TargetCustomers_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_TargetCustomers_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_StockDetails_CB_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_StockDetails_CB_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_SalesVouchers_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_SalesVouchers_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_SalesTeam_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_SalesTeam_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_ReceiptRegister_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_ReceiptRegister_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_PurchaseSummary_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_PurchaseSummary_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_PotentialCustomers_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_PotentialCustomers_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_OutStandingsHistory_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_OutStandingsHistory_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_OutStandings_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_OutStandings_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_ItemsList_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_ItemsList_Load]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_CustomerList_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[USP_SLSS_CustomerList_Load]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_TargetCustomers]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_TargetCustomers] DROP CONSTRAINT IF EXISTS [DF__tbl_Targe__Creat__2180FB33]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_StockDetails_CB]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_StockDetails_CB] DROP CONSTRAINT IF EXISTS [DF__tbl_Stock__Creat__31B762FC]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_SalesVouchers]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_SalesVouchers] DROP CONSTRAINT IF EXISTS [DF__tbl_Sales__Creat__2739D489]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_SalesTeam]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_SalesTeam] DROP CONSTRAINT IF EXISTS [DF__tbl_Sales__Creat__2A164134]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_ReceiptRegister]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_ReceiptRegister] DROP CONSTRAINT IF EXISTS [DF__tbl_Recei__Creat__160F4887]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_PurchaseSummary]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_PurchaseSummary] DROP CONSTRAINT IF EXISTS [DF__tbl_Purch__Creat__3493CFA7]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_PotentialCustomers]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_PotentialCustomers] DROP CONSTRAINT IF EXISTS [DF__tbl_Poten__Creat__6442E2C9]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_OutStandings]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_OutStandings] DROP CONSTRAINT IF EXISTS [DF__tbl_OutSt__Creat__1EA48E88]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_ItemsList]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_ItemsList] DROP CONSTRAINT IF EXISTS [DF__tbl_Items__Creat__2CF2ADDF]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_CustomerList]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_CustomerList] DROP CONSTRAINT IF EXISTS [DF__tbl_Custo__Creat__5224328E]
GO
/****** Object:  Table [dbo].[tbl_TargetCustomersHistory]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_TargetCustomersHistory]
GO
/****** Object:  Table [dbo].[tbl_TargetCustomers]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_TargetCustomers]
GO
/****** Object:  Table [dbo].[tbl_StockDetails_CB]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_StockDetails_CB]
GO
/****** Object:  Table [dbo].[tbl_SalesVouchers]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_SalesVouchers]
GO
/****** Object:  Table [dbo].[tbl_SalesTeam]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_SalesTeam]
GO
/****** Object:  Table [dbo].[tbl_ReceiptRegister]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_ReceiptRegister]
GO
/****** Object:  Table [dbo].[tbl_PurchaseSummary]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_PurchaseSummary]
GO
/****** Object:  Table [dbo].[tbl_PotentialCustomers]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_PotentialCustomers]
GO
/****** Object:  Table [dbo].[tbl_OutStandingsHistory]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_OutStandingsHistory]
GO
/****** Object:  Table [dbo].[tbl_OutStandings]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_OutStandings]
GO
/****** Object:  Table [dbo].[tbl_ItemsList]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_ItemsList]
GO
/****** Object:  Table [dbo].[tbl_CustomerList]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_CustomerList]
GO
/****** Object:  Table [dbo].[tbl_Calendar]    Script Date: 9/12/2023 6:50:48 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_Calendar]
GO
/****** Object:  Table [dbo].[tbl_Calendar]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Calendar](
	[CalendarDate] [datetime] NULL,
	[CalendarDay] [varchar](10) NULL,
	[CalendarMonth] [varchar](10) NULL,
	[CalendarQuarter] [varchar](10) NULL,
	[CalendarYear] [varchar](10) NULL,
	[DayOfWeekNum] [varchar](10) NULL,
	[DayOfWeekName] [varchar](10) NULL,
	[DateNum] [varchar](10) NULL,
	[FiscalQuarter] [varchar](20) NULL,
	[MonthName] [varchar](10) NULL,
	[FullMonthName] [varchar](10) NULL,
	[HolidayName] [varchar](50) NULL,
	[HolidayFlag] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_CustomerList]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_CustomerList](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Customer ID] [nvarchar](255) NOT NULL,
	[Customer Name] [nvarchar](255) NULL,
	[Legal Name of Business] [nvarchar](255) NULL,
	[Trade Name] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
	[Contact Person] [nvarchar](255) NULL,
	[Address-1] [nvarchar](255) NULL,
	[Address-2] [nvarchar](255) NULL,
	[Address-3] [nvarchar](255) NULL,
	[Country] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Pin Code] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Mobile No] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[GST No] [nvarchar](255) NULL,
	[Aadhar No] [nvarchar](255) NULL,
	[PAN No] [nvarchar](255) NOT NULL,
	[Credit days] [nvarchar](255) NULL,
	[Credit Limit in INR] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Sales Person] [nvarchar](255) NULL,
	[Customer Category] [nvarchar](255) NULL,
	[Customer Type] [nvarchar](255) NULL,
	[WhatsApp No] [nvarchar](255) NULL,
	[District] [nvarchar](255) NULL,
	[Taluka] [nvarchar](255) NULL,
	[Potential] [nvarchar](255) NULL,
	[Target] [nvarchar](255) NULL,
	[DOB] [date] NULL,
	[Anniversary] [nvarchar](255) NULL,
	[Date of Creation] [date] NULL,
	[Status] [nvarchar](255) NULL,
	[Turn Over] [nvarchar](255) NULL,
	[MSME No] [nvarchar](255) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_CustomerList] PRIMARY KEY CLUSTERED 
(
	[Customer ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ItemsList]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ItemsList](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Item Name] [nvarchar](255) NULL,
	[Item Group] [nvarchar](255) NULL,
	[Item Category] [nvarchar](255) NULL,
	[Durastrong(Yes/No)] [nvarchar](255) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_ItemsList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_OutStandings]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_OutStandings](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Bill NO] [nvarchar](255) NULL,
	[Bill Date] [date] NULL,
	[Customer ID] [nvarchar](255) NULL,
	[Customer Name] [nvarchar](255) NULL,
	[Sales Person -1] [nvarchar](255) NULL,
	[Sales Person -2] [nvarchar](255) NULL,
	[Due Date] [date] NULL,
	[Due Days] [int] NULL,
	[Ageing] [int] NULL,
	[Pending Amount] [decimal](18, 4) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_OutStandings] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_OutStandingsHistory]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_OutStandingsHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Bill NO] [nvarchar](255) NULL,
	[Bill Date] [date] NULL,
	[Customer ID] [nvarchar](255) NULL,
	[Customer Name] [nvarchar](255) NULL,
	[Sales Person -1] [nvarchar](255) NULL,
	[Sales Person -2] [nvarchar](255) NULL,
	[Due Date] [date] NULL,
	[Due Days] [int] NULL,
	[Ageing] [int] NULL,
	[Pending Amount] [decimal](18, 4) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_OutStandingsHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PotentialCustomers]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PotentialCustomers](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Team Name] [nvarchar](255) NULL,
	[Customer ID] [nvarchar](255) NULL,
	[Customer Name] [nvarchar](255) NULL,
	[GST No] [nvarchar](255) NULL,
	[Sales Person] [nvarchar](255) NULL,
	[Potential Qty] [nvarchar](255) NULL,
	[Item Details] [nvarchar](255) NULL,
	[Date] [nvarchar](255) NULL,
	[Month] [nvarchar](255) NULL,
	[Quarter] [nvarchar](255) NULL,
	[Year] [nvarchar](255) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_PotentialCustomers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PurchaseSummary]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PurchaseSummary](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Purchase Date] [date] NULL,
	[Creation Date] [date] NULL,
	[Invoice No] [nvarchar](255) NULL,
	[Voucher Type] [nvarchar](255) NULL,
	[Vendor] [nvarchar](255) NULL,
	[Godown Name] [nvarchar](255) NULL,
	[Product Name] [nvarchar](255) NULL,
	[Unit Of Measurement] [nvarchar](255) NULL,
	[Actual Qty] [nvarchar](255) NULL,
	[Billed Qty] [nvarchar](255) NULL,
	[Actual Pcs] [nvarchar](255) NULL,
	[Billed Pcs] [nvarchar](255) NULL,
	[Difference Qty] [nvarchar](255) NULL,
	[Rate] [nvarchar](255) NULL,
	[Value] [nvarchar](255) NULL,
	[Date Time] [datetime] NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_PurchaseSummary] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ReceiptRegister]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ReceiptRegister](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Receipt Date] [date] NULL,
	[Customer ID] [nvarchar](255) NULL,
	[Customer Name] [nvarchar](255) NULL,
	[Sales Person -1] [nvarchar](255) NULL,
	[Sales Person -2] [nvarchar](255) NULL,
	[Voucher Type] [nvarchar](255) NULL,
	[Voucher No] [nvarchar](255) NULL,
	[Debit Amount] [decimal](18, 4) NULL,
	[Credit Amount] [decimal](18, 4) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_ReceiptRegister] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SalesTeam]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SalesTeam](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[EMP ID] [nvarchar](255) NULL,
	[Sales Person] [nvarchar](255) NULL,
	[Team Name] [nvarchar](255) NULL,
	[Reporting Manager] [nvarchar](255) NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_SalesTeam] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SalesVouchers]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SalesVouchers](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Voucher Date] [date] NULL,
	[Voucher No] [nvarchar](255) NULL,
	[Customer Name] [nvarchar](255) NULL,
	[Customer GSTNo] [nvarchar](255) NULL,
	[PAN No] [nvarchar](255) NULL,
	[Customer ID] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
	[Product Name] [nvarchar](255) NULL,
	[Godown Name] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Voucher Type] [nvarchar](255) NULL,
	[Sales Person -1] [nvarchar](255) NULL,
	[Sales Person -2] [nvarchar](255) NULL,
	[Item Details] [nvarchar](255) NULL,
	[Item Category] [nvarchar](255) NULL,
	[Qty(MTs)] [decimal](18, 4) NULL,
	[Qty(Nos)] [int] NULL,
	[Qty(Box)] [int] NULL,
	[Qty(Pcs)] [int] NULL,
	[Amount] [decimal](18, 4) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_SalesVouchers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_StockDetails_CB]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_StockDetails_CB](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Company Name] [nvarchar](255) NULL,
	[Godown Name] [nvarchar](255) NULL,
	[Item Details] [nvarchar](255) NULL,
	[Qty] [nvarchar](255) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_StockDetails-CB] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_TargetCustomers]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_TargetCustomers](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Team Name] [nvarchar](255) NULL,
	[Customer ID] [nvarchar](255) NULL,
	[Customer Name] [nvarchar](255) NULL,
	[GST No] [nvarchar](255) NULL,
	[Sales Person] [nvarchar](255) NULL,
	[Target Qty] [nvarchar](255) NULL,
	[Item Details] [nvarchar](255) NULL,
	[Date] [nvarchar](255) NULL,
	[Month] [nvarchar](255) NULL,
	[Quarter] [nvarchar](255) NULL,
	[Year] [nvarchar](255) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_TargetCustomers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_TargetCustomersHistory]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_TargetCustomersHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Branch Name] [nvarchar](255) NULL,
	[Team Name] [nvarchar](255) NULL,
	[Customer ID] [nvarchar](255) NULL,
	[Customer Name] [nvarchar](255) NULL,
	[GST No] [nvarchar](255) NULL,
	[Sales Person] [nvarchar](255) NULL,
	[Target Qty] [nvarchar](255) NULL,
	[Item Details] [nvarchar](255) NULL,
	[Date] [nvarchar](255) NULL,
	[Month] [nvarchar](255) NULL,
	[Quarter] [nvarchar](255) NULL,
	[Year] [nvarchar](255) NULL,
	[Created Date] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_TargetCustomersHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_CustomerList] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
ALTER TABLE [dbo].[tbl_ItemsList] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
ALTER TABLE [dbo].[tbl_OutStandings] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
ALTER TABLE [dbo].[tbl_PotentialCustomers] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
ALTER TABLE [dbo].[tbl_PurchaseSummary] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
ALTER TABLE [dbo].[tbl_ReceiptRegister] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
ALTER TABLE [dbo].[tbl_SalesTeam] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
ALTER TABLE [dbo].[tbl_SalesVouchers] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
ALTER TABLE [dbo].[tbl_StockDetails_CB] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
ALTER TABLE [dbo].[tbl_TargetCustomers] ADD  DEFAULT (getdate()) FOR [Created Date]
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_CustomerList_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  Customer List table load
 
-- ==========================================  
CREATE         PROCEDURE [dbo].[USP_SLSS_CustomerList_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

Drop Table If Exists #CustomerList;

--Truncate table [dbo].[tbl_CustomerList];
SELECT DIstinct  [Branch Name],[Customer ID],[Customer Name],[Legal Name of Business],[Trade Name],[Group],[Contact Person],[Address-1],[Address-2],[Address-3],
[Country],[State],[Pin Code],[Phone],[Mobile No],[Email],[GST No],[Aadhar No],[PAN No],[Credit days],[Credit Limit in INR],[Location],[Sales Person],
[Customer Category],[Customer Type],[WhatsApp No],[District],[Taluka],[Potential],[Target],[DOB],[Anniversary],[Date of Creation],[Status],[Turn Over],[MSME No]
Into #CustomerList
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Customer List.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Customer List$]')
	
	MERGE [dbo].[tbl_CustomerList] AS Target
    USING #CustomerList	AS Source
    ON Source.[Customer ID] = Target.[Customer ID]    
    -- For Inserts
    WHEN NOT MATCHED BY Target THEN
        INSERT ([Branch Name],[Customer ID],[Customer Name],[Legal Name of Business],[Trade Name],[Group],[Contact Person],[Address-1],[Address-2],[Address-3],
		[Country],[State],[Pin Code],[Phone],[Mobile No],[Email],[GST No],[Aadhar No],[PAN No],[Credit days],[Credit Limit in INR],[Location],[Sales Person],
		[Customer Category],[Customer Type],[WhatsApp No],[District],[Taluka],[Potential],[Target],[DOB],[Anniversary],[Date of Creation],[Status],[Turn Over],[MSME No]) 
        VALUES ( Source.[Branch Name] ,Source.[Customer ID] ,Source.[Customer Name] ,Source.[Legal Name of Business] ,Source.[Trade Name] ,Source.[Group] ,Source.[Contact Person]
		 ,Source.[Address-1] ,Source.[Address-2] ,Source.[Address-3] ,Source.[Country] ,Source.[State] ,Source.[Pin Code] ,Source.[Phone] ,Source.[Mobile No] ,Source.[Email]
		 ,Source.[GST No] ,Source.[Aadhar No] ,Source.[PAN No] ,Source.[Credit days] ,Source.[Credit Limit in INR] ,Source.[Location] ,Source.[Sales Person] ,Source.[Customer Category]
		 ,Source.[Customer Type] ,Source.[WhatsApp No] ,Source.[District] ,Source.[Taluka] ,Source.[Potential] ,Source.[Target] ,Source.[DOB] ,Source.[Anniversary]
		 ,Source.[Date of Creation] ,Source.[Status] ,Source.[Turn Over] ,Source.[MSME No] )    
    -- For Updates
    WHEN MATCHED  AND (Target.[Branch Name]  <> Source.[Branch Name]
			OR  Target.[Customer ID]  <> Source.[Customer ID]
			OR  Target.[Customer Name]  <> Source.[Customer Name]
			OR  Target.[Legal Name of Business]  <> Source.[Legal Name of Business]
			OR  Target.[Trade Name]  <> Source.[Trade Name]
			OR  Target.[Group]  <> Source.[Group]
			OR  Target.[Contact Person]  <> Source.[Contact Person]
			OR  Target.[Address-1]  <> Source.[Address-1]
			OR  Target.[Address-2]  <> Source.[Address-2]
			OR  Target.[Address-3]  <> Source.[Address-3]
			OR  Target.[Country]  <> Source.[Country]
			OR  Target.[State]  <> Source.[State]
			OR  Target.[Pin Code]  <> Source.[Pin Code]
			OR  Target.[Phone]  <> Source.[Phone]
			OR  Target.[Mobile No]  <> Source.[Mobile No]
			OR  Target.[Email]  <> Source.[Email]
			OR  Target.[GST No]  <> Source.[GST No]
			OR  Target.[Aadhar No]  <> Source.[Aadhar No]
			OR  Target.[PAN No]  <> Source.[PAN No]
			OR  Target.[Credit days]  <> Source.[Credit days]
			OR  Target.[Credit Limit in INR]  <> Source.[Credit Limit in INR]
			OR  Target.[Location]  <> Source.[Location]
			OR  Target.[Sales Person]  <> Source.[Sales Person]
			OR  Target.[Customer Category]  <> Source.[Customer Category]
			OR  Target.[Customer Type]  <> Source.[Customer Type]
			OR  Target.[WhatsApp No]  <> Source.[WhatsApp No]
			OR  Target.[District]  <> Source.[District]
			OR  Target.[Taluka]  <> Source.[Taluka]
			OR  Target.[Potential]  <> Source.[Potential]
			OR  Target.[Target]  <> Source.[Target]
			OR  Target.[DOB]  <> Source.[DOB]
			OR  Target.[Anniversary]  <> Source.[Anniversary]
			OR  Target.[Date of Creation]  <> Source.[Date of Creation]
			OR  Target.[Status]  <> Source.[Status]
			OR  Target.[Turn Over]  <> Source.[Turn Over]
			OR  Target.[MSME No]   <> Source.[MSME No] )
   THEN 
	UPDATE SET
        Target.[Branch Name]  = Source.[Branch Name] ,
		Target.[Customer ID]  = Source.[Customer ID] ,
		Target.[Customer Name]  = Source.[Customer Name] ,
		Target.[Legal Name of Business]  = Source.[Legal Name of Business] ,
		Target.[Trade Name]  = Source.[Trade Name] ,
		Target.[Group]  = Source.[Group] ,
		Target.[Contact Person]  = Source.[Contact Person] ,
		Target.[Address-1]  = Source.[Address-1] ,
		Target.[Address-2]  = Source.[Address-2] ,
		Target.[Address-3]  = Source.[Address-3] ,
		Target.[Country]  = Source.[Country] ,
		Target.[State]  = Source.[State] ,
		Target.[Pin Code]  = Source.[Pin Code] ,
		Target.[Phone]  = Source.[Phone] ,
		Target.[Mobile No]  = Source.[Mobile No] ,
		Target.[Email]  = Source.[Email] ,
		Target.[GST No]  = Source.[GST No] ,
		Target.[Aadhar No]  = Source.[Aadhar No] ,
		Target.[PAN No]  = Source.[PAN No] ,
		Target.[Credit days]  = Source.[Credit days] ,
		Target.[Credit Limit in INR]  = Source.[Credit Limit in INR] ,
		Target.[Location]  = Source.[Location] ,
		Target.[Sales Person]  = Source.[Sales Person] ,
		Target.[Customer Category]  = Source.[Customer Category] ,
		Target.[Customer Type]  = Source.[Customer Type] ,
		Target.[WhatsApp No]  = Source.[WhatsApp No] ,
		Target.[District]  = Source.[District] ,
		Target.[Taluka]  = Source.[Taluka] ,
		Target.[Potential]  = Source.[Potential] ,
		Target.[Target]  = Source.[Target] ,
		Target.[DOB]  = Source.[DOB] ,
		Target.[Anniversary]  = Source.[Anniversary] ,
		Target.[Date of Creation]  = Source.[Date of Creation] ,
		Target.[Status]  = Source.[Status] ,
		Target.[Turn Over]  = Source.[Turn Over] ,
		Target.[MSME No]   = Source.[MSME No]  
;

Drop Table If Exists #CustomerList;
 
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_ItemsList_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  ItemsList table load
 
-- ==========================================  
CREATE         PROCEDURE [dbo].[USP_SLSS_ItemsList_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

--Items List Loading     
INSERT INTO [dbo].[tbl_ItemsList]
([Item Name] ,[Item Group],[Item Category],[Durastrong(Yes/No)] ) 

SELECT DIstinct 
[Item Name] ,[Item Group],[Item Category],[Durastrong(Yes/No)] 
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Items List.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Items List$]')
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_OutStandings_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  OutStandings table load
 
-- ==========================================  
CREATE           PROCEDURE [dbo].[USP_SLSS_OutStandings_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

INSERT INTO [dbo].[tbl_OutStandings]
([Branch Name],[Bill NO],[Bill Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Due Date],[Due Days],[Ageing],[Pending Amount]) 

SELECT DIstinct [Branch Name],[Bill NO],[Bill Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Due Date],[Due Days],[Ageing],[Pending Amount]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Outstandings.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Outstandings$]') 
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_OutStandingsHistory_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  OutStandingsHistory table load
 
-- ==========================================  
CREATE         PROCEDURE [dbo].[USP_SLSS_OutStandingsHistory_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

INSERT INTO [dbo].[tbl_OutStandingsHistory]
([Branch Name],[Bill NO],[Bill Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Due Date],[Due Days],[Ageing],[Pending Amount],[Created Date]) 

SELECT   [Branch Name],[Bill NO],[Bill Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Due Date],[Due Days],[Ageing],[Pending Amount],[Created Date]
FROM  [dbo].[tbl_OutStandings] With(nolock)
Where YEAR([Created Date]) = YEAR(Getdate()) and MONTH([Created Date]) = MONTH(Getdate())-1  --DATEADD(month, -1, GETDATE())

Delete FROM  [dbo].[tbl_OutStandings]  
Where YEAR([Created Date]) = YEAR(Getdate()) and MONTH([Created Date]) = MONTH(Getdate())-1  --DATEADD(month, -1, GETDATE())
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_PotentialCustomers_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  Potential Customers table load
 
-- ==========================================  
CREATE               PROCEDURE [dbo].[USP_SLSS_PotentialCustomers_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

INSERT INTO [dbo].[tbl_PotentialCustomers]
([Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Potential Qty],[Item Details],[Date],[Month],[Quarter],[Year]) 

SELECT  DIstinct [Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Potential Qty],[Item Details],[Date],[Month],[Quarter],[Year]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Potential Customers.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Potential Customers$]')
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_PurchaseSummary_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  PurchaseSummarytable load
 
-- ==========================================  
CREATE         PROCEDURE [dbo].[USP_SLSS_PurchaseSummary_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

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
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_ReceiptRegister_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  ReceiptRegister table load
 
-- ==========================================  
CREATE         PROCEDURE [dbo].[USP_SLSS_ReceiptRegister_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

--ReceiptRegister   Loading       insert and update -- [Receipt Date],[Customer ID] 
INSERT INTO [dbo].[tbl_ReceiptRegister]
([Branch Name],[Receipt Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Voucher Type],[Voucher No],[Debit Amount],[Credit Amount]) 

SELECT DIstinct [Branch Name],[Receipt Date],[Customer ID],[Customer Name],[Sales Person -1],[Sales Person -2],[Voucher Type],[Voucher No],[Debit Amount],[Credit Amount]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Receipt Register.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Receipt Register$]') 
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_SalesTeam_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  SalesTeam table load
 
-- ==========================================  
CREATE         PROCEDURE [dbo].[USP_SLSS_SalesTeam_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

--SalesTeam Loading    
INSERT INTO [dbo].[tbl_SalesTeam]
([EMP ID],[Sales Person],[Team Name],[Reporting Manager],[Branch Name] )

SELECT DIstinct 
[EMP ID],[Sales Person],[Team Name],[Reporting Manager],[Branch Name] 
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Sales Team.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Sales Team$]')
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_SalesVouchers_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  Sales Vouchers table load
 
-- ==========================================  
CREATE         PROCEDURE [dbo].[USP_SLSS_SalesVouchers_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

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
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_StockDetails_CB_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  StockDetails-CB table load
 
-- ==========================================  
CREATE         PROCEDURE [dbo].[USP_SLSS_StockDetails_CB_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

--Stock Details-CB Loading     
INSERT INTO [dbo].[tbl_StockDetails_CB] 
( [Branch Name] ,[Company Name] ,[Godown Name] ,[Item Details] ,[Qty] )

SELECT DIstinct 
 [Branch Name] ,[Company Name] ,[Godown Name] ,[Item Details] ,[Qty] 
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Stock Details-CB.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Stock Details-CB$]')
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_TargetCustomers_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  TargetCustomers table load
 
-- ==========================================  
CREATE           PROCEDURE [dbo].[USP_SLSS_TargetCustomers_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

INSERT INTO [dbo].[tbl_TargetCustomers]
([Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Target Qty],[Item Details],[Date],[Month],[Quarter],[Year]) 

SELECT  DIstinct [Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Target Qty],[Item Details],[Date],[Month],[Quarter],[Year]
FROM OPENROWSET(
'Microsoft.ACE.OLEDB.12.0' 
,'Excel 12.0;Database=F:\DW Project\Requirements\Source_Files\Target Customers.xlsx; HDR=YES;IMEX=1'
,'SELECT * FROM [Target Customers$]')
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
/****** Object:  StoredProcedure [dbo].[USP_SLSS_TargetCustomersHistory_Load]    Script Date: 9/12/2023 6:50:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================  
-- Create date: 25 August, 2023  
-- Description:  TargetCustomersHistory table load
 
-- ==========================================  
CREATE         PROCEDURE [dbo].[USP_SLSS_TargetCustomersHistory_Load] (  
 -- Add the parameters for the stored procedure here  
@Transaction_Status   Int = -1 Output,  
@Transaction_Message  Varchar(500) = '' Output   
)  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Define this Block for Locating Exceptions are coming while Transactions are in Progress.  	  
 Begin Try  
  -- Begin Database Transactions.  
  Begin Transaction    

INSERT INTO [dbo].[tbl_TargetCustomersHistory]
([Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Target Qty],[Item Details],[Date],[Month],[Quarter],[Year],[Created Date]) 

SELECT   [Branch Name],[Team Name],[Customer ID],[Customer Name],[GST No],[Sales Person],[Target Qty],[Item Details],[Date],[Month],[Quarter],[Year],[Created Date]
FROM  [dbo].[tbl_TargetCustomers] With(nolock)
Where YEAR([Created Date]) = YEAR(Getdate()) and MONTH([Created Date]) = MONTH(Getdate())-1  --DATEADD(month, -1, GETDATE())

--Delete FROM  [dbo].[tbl_TargetCustomers] 
--Where YEAR([Created Date]) = YEAR(Getdate()) and MONTH([Created Date]) = MONTH(Getdate())-1  --DATEADD(month, -1, GETDATE())
  
  -- Commit Database Transactions.  
  Commit Transaction  
 End Try  
 Begin Catch  
  -- Getting If any Exception is coming while Transactions are in Progress.  
  Select @Transaction_Status = -1, @Transaction_Message = 'Error No. ' + CAST(ERROR_NUMBER() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Message : ' + ERROR_MESSAGE() + CHAR(10) +   
                                 'Error in Procedure : ' + ERROR_PROCEDURE() + CHAR(10) +   
                                 'Error Severity : ' + CAST(ERROR_SEVERITY() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error Line No. ' + CAST(ERROR_LINE() AS VARCHAR(10)) + CHAR(10) +   
                                 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));  
  -- Roll back Database Transaction if any Error is coming.  
  Rollback Transaction  
 End Catch;   
 Return  
END  
GO
