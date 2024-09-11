--Drop Table IF Exists [tbl_Calendar]

--CREATE TABLE [tbl_Calendar]
--(
--    [CalendarDate] DATETIME,
--	[CalendarDay]  varchar(10),
--	[CalendarMonth] varchar(10),
--	[CalendarQuarter] varchar(10),
--	[CalendarYear] varchar(10),
--	[DayOfWeekNum] varchar(10),
--	[DayOfWeekName] varchar(10),
--	[DateNum] varchar(10),
--	[FiscalQuarter] varchar(20),
--	[MonthName] varchar(10),
--	[FullMonthName] varchar(10),
--	[HolidayName] varchar(50),
--	[HolidayFlag] varchar(10)
--)
--Go

---load the data year wise
DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = '2039-04-01' --GETDATE()
SET @EndDate =  '2040-03-31' --DATEADD(d, 365, @StartDate)


DECLARE @Current_DateTime DATETIME--= SYSDATETIMEOFFSET() AT TIME ZONE 'India Standard Time'; -- GETDATE()
Declare @FinancialYear varchar(20);
SET @Current_DateTime= @StartDate --'20230401'; -- uncomment this line to test with your desired date.
 
SELECT 
--DATEFROMPARTS(Yr, 4, 1) AS FinancialYear_StartDate,
--DATEFROMPARTS(Yr + 1, 3, 31) AS FinancialYear_EndDate,
@FinancialYear = CONCAT(Yr,'-',RIGHT(Yr+1,2))  
FROM
(SELECT CASE WHEN DATEPART(MONTH, @Current_DateTime ) < 4 
THEN DATEPART(YEAR, @Current_DateTime ) - 1 ELSE DATEPART(YEAR, @Current_DateTime ) END Yr) a;

WHILE @StartDate <= @EndDate
      BEGIN
             INSERT INTO [tbl_Calendar]
             (
				   CalendarDate,
				   CalendarDay,
				   CalendarMonth,
				   CalendarQuarter,
				   CalendarYear,
				   DayOfWeekNum,
				   DayOfWeekName,
				   DateNum,
				   FiscalQuarter,
				   MonthName,
				   FullMonthName,
				   HolidayName,
				   HolidayFlag
             )
             SELECT
                   @StartDate,
				   DAY(@StartDate),
				   MONTH(@StartDate),
				   DATEPART(QUARTER, (@StartDate)),
				   YEAR(@StartDate),
				   DATEPART(WEEKDAY, (@StartDate)),
   				   DATENAME(WEEKDAY, (@StartDate)),
				   CONVERT(VARCHAR(10), @StartDate, 112),
				   --CONVERT(VARCHAR(10), YEAR(@StartDate)) + 'Q' + CONVERT(VARCHAR(10) ,DATEPART(QUARTER, (@StartDate))),
				   CASE  
						WHEN MONTH(@StartDate) IN (1,2,3)  THEN  @FinancialYear + '-Q4'  --convert(char(4), YEAR(@StartDate)  ) + '- Q4'
						WHEN MONTH(@StartDate) IN (4,5,6)  THEN @FinancialYear + '-Q1'  --convert(char(4), YEAR(@StartDate)  ) + '- Q1'
						WHEN MONTH(@StartDate) IN (7,8,9)  THEN @FinancialYear + '-Q2'  --convert(char(4), YEAR(@StartDate)  ) + '- Q2'
						WHEN MONTH(@StartDate) IN (10,11,12) THEN @FinancialYear + '-Q3'  --convert(char(4), YEAR(@StartDate) ) + '- Q3'
					END AS Quarter ,
   				   LEFT(DATENAME(MONTH, (@StartDate)),3),
				   DATENAME(MONTH, (@StartDate)),
				   NULL,
				   'N'


             SET @StartDate = DATEADD(dd, 1, @StartDate)


      END
 

select * from [tbl_Calendar] ORDER BY 1  DESC

--Update s
--Set s.[HolidayFlag] ='Y'
--From [dbo].[tbl_Calendar] s
--Where DayOfWeekName='Sunday'

