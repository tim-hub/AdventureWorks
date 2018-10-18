if exists (select * from sys.tables where name='DQLog')
	drop table DQLog;
go

CREATE TABLE DQLog(
	LogID int Primary KEY IDENTITY(1,1),
	RowID BINARY(8) NOT NULL,
	DBName nvarchar(20) NOT NULL,
	TableName nvarchar(20) NOT NULL,
	RuleNo tinyint not null check (RuleNo >= 1 and RuleNo <=52),
	Action nvarchar(6) not null  check (Action in ('Allow', 'Fix', 'Reject'))
)