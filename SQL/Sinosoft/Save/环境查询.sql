----Start Sql Server��ѯ������������-------------------------------
--��ѯ������
select request_session_id as spid,OBJECT_NAME(resource_associated_entity_id) as tableName   
from sys.dm_tran_locks where resource_type='OBJECT'
--������
declare @spid  int 
Set @spid  = 53 --�������
declare @sql varchar(1000)
set @sql='kill '+cast(@spid as varchar)
exec(@sql)
----End Sql Server��ѯ������������-------------------------------

