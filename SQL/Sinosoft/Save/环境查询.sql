----Start Sql Server查询锁表及解锁操作-------------------------------
--查询被锁表
select request_session_id as spid,OBJECT_NAME(resource_associated_entity_id) as tableName   
from sys.dm_tran_locks where resource_type='OBJECT'
--解锁表
declare @spid  int 
Set @spid  = 53 --锁表进程
declare @sql varchar(1000)
set @sql='kill '+cast(@spid as varchar)
exec(@sql)
----End Sql Server查询锁表及解锁操作-------------------------------

