SELECT DIstinct  
       [CalendarMonth] 
      ,[MonthName] 
  FROM [SLSS_DataLake].[dbo].[tbl_Calendar]  where LEFT([FiscalQuarter], 7) =CONCAT(YEAR(GETDATE()),'-',RIGHT(YEAR(GETDATE())+1,2)) order by 1
  --select CONCAT(YEAR(GETDATE()),'-',RIGHT(YEAR(GETDATE())+1,2))  
  SELECT  CAST(DATEADD(wk, DATEDIFF(wk,0,GETDATE()), 0) as Date) as Monday ,   
  CAST(DATEADD(WEEK, 1,  DATEADD(DAY, -1 * datepart(weekday, GETDATE()), GETDATE())) as Date) as  Saturday

  --Working days count in current month
Declare @Workingdays as Int;
SELECT  @Workingdays=COUNT([CalendarDate])
FROM [dbo].[tbl_Calendar] with(nolock)
WHere [HolidayFlag] <> 'Y' and 
YEAR([CalendarDate]) = YEAR(Getdate() )  and 
MONTH([CalendarDate]) = MONTH(Getdate() ) and
CAST([CalendarDate]  as Date) >  CAST(Getdate()  as Date)
   
