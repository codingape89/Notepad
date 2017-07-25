ORACLE_JDBC_DRIVER_PATH

BOCLIFE_AMS_POOL

jdbc:oracle:thin:@192.168.42.200:1521:AML


if exists (select 1
            from  sysobjects
           where  id = object_id('LDTaskType')
            and   type = 'U')
   drop table LDTaskType
go
create table LDTaskType (
  TTypeCode            nvarchar(20)         not null,
  TTypeName            nvarchar(50)         not null,
  Remark               nvarchar(500)        null,
  Operator             nvarchar(60)         not null,
  MakeDate             date                 not null,
  MakeTime             nvarchar(8)          not null,
  ModifyDate           date                 not null,
  ModifyTime           nvarchar(8)          not null
  constraint PK_LDTaskType primary key (TTypeCode)
)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LAProject')
            and   type = 'U')
   drop table LAProject
go
create table LAProject (
  ProjectCode          nvarchar(20)         not null,
  ProjectName          nvarchar(50)         not null,
  ParentProjectCode    nvarchar(20)         not null,
  Status               nvarchar(2)          not null,
  StartDate            date                 null,
  EndDate              date                 null,
  Remark               nvarchar(500)        null,
  Operator             nvarchar(60)         not null,
  MakeDate             date                 not null,
  MakeTime             nvarchar(8)          not null,
  ModifyDate           date                 not null,
  ModifyTime           nvarchar(8)          not null
  constraint PK_LAProject primary key (ProjectCode)
)
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LATask')
            and   type = 'U')
   drop table LATask
go
create table LATask (
  ProjectCode          nvarchar(20)         not null,
  TaskCode             nvarchar(20)         not null,
  TaskName             nvarchar(500)        not null,
  Status               nvarchar(2)          not null,
  StartDate            date                 not null,
  PEndDate             date                 null,
  EndDate              date                 null,
  Content              nvarchar(4000)       null,
  Remark               nvarchar(500)        null,
  Operator             nvarchar(60)         not null,
  MakeDate             date                 not null,
  MakeTime             nvarchar(8)          not null,
  ModifyDate           date                 not null,
  ModifyTime           nvarchar(8)          not null
  constraint PK_LATask primary key (ProjectCode,TaskCode)
)
go


if exists (select 1
          from sysobjects
          where  id = object_id('dbo.CurrentDate')
          and type in ('IF', 'FN', 'TF'))
   drop function dbo.CurrentDate
go
create function dbo.CurrentDate ()
RETURNS Date
AS
BEGIN
  RETURN convert(char(10),GetDate(),120)
END
go

if exists (select 1
          from sysobjects
          where  id = object_id('dbo.CurrentTime')
          and type in ('IF', 'FN', 'TF'))
   drop function dbo.CurrentTime
go
create function dbo.CurrentTime ()
RETURNS VARCHAR(8)
AS
BEGIN
  /* Function body */
  RETURN convert(char(10),GetDate(),108)
END
go
