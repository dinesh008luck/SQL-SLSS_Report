SELECT  * 
  FROM [SLSS_DataLake].[dbo].[Reports_WeeklyTargetVsAchv_ReportTable]


PATHCONTAINS(tbl_SalesTeam[Hierarchy],
MaxX(
Filter(
tbl_SalesTeam,
[Email ID] = USERPRINCIPALNAME()
)
,tbl_SalesTeam[EMP ID]
)
)

Hierarchy = PATH(tbl_SalesTeam[EMP ID],tbl_SalesTeam[Reporting Manager EMP ID])
