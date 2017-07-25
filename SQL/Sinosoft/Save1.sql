
查看：
select   
    request_session_id spid,  
    OBJECT_NAME(resource_associated_entity_id) tableName   
from   
    sys.dm_tran_locks  
where   
    resource_type='OBJECT'

杀死：
kill 62

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

----Start RedMine相关查询（MySQL）-------------------------------
select * from issues;
select * from projects;

select 
CONCAT((SELECT value FROM custom_values where custom_field_id='24' and customized_id=a.id),'_',subject) 
,a.* from issues a 
where project_id='8' 
and exists (SELECT 1 FROM custom_values where custom_field_id='24' and customized_id=a.id and value<>'');
 
update a 
set subject=CONCAT((SELECT value FROM custom_values where custom_field_id='24' and customized_id=a.id),'_',subject) 
from issues a 
where project_id='8' 
and exists (SELECT 1 FROM custom_values where custom_field_id='24' and customized_id=a.id and value<>'');
----Start RedMine相关查询-------------------------------


select * from latask a where projectcode='MetLifeHK_PCMS&Portal' 
--and taskstatus='1' 
and exists (select 1 from latask where substring(taskcode,1,(case tasktype when 'BUG' then 11 else 10 end))
 =substring(a.taskcode,1,(case tasktype when 'BUG' then 11 else 10 end)) and taskstatus='1') 
order by taskcode;
















--Normal b.plantype in ('1','2','3','4','6','8') 
select 
c.financeperiod
,c.yearmonth
,c.monthlyfinance
,(select sum(monthlyfinance) from laagentfpdetail where agentcode=a.agentcode and yearmonth>=b.financestartmonth and yearmonth<=a.bakmonth) as CTM_MF
,c.welcomeincentive
,c.monthlyfinanceadvance
,c.validationreq
,(select sum(validationreq) from laagentfpdetail where agentcode=a.agentcode and yearmonth>=b.financestartmonth and yearmonth<=a.bakmonth and financeperiod=c.financeperiod) as Period_CTM_Req
,coalesce((select sum(amount) from labonusproductiondata t1 where wageno=a.bakmonth and agentcode=a.agentcode and indextype in ('01','11') and bonustype='FP_MF' and bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or b.plantype in ('1','2','3','4') then 'P_NAFYC' else 'P_NAFYC_NoOwnPolicy' end) and not exists (select top 1 1 from labonusproductiondata where wageno=t1.wageno and indextype in ('01','11') and indextype>t1.indextype)),0) as P_CM_NAFYC
,coalesce((select sum(amount) from labonusproductiondata t1 where wageno=a.bakmonth and agentcode=a.agentcode and indextype in ('01','11') and bonustype='FP_MF' and bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or b.plantype in ('1','2','3','4') then '' else 'DR_NAFYC' end) and not exists (select top 1 1 from labonusproductiondata where wageno=t1.wageno and indextype in ('01','11') and indextype>t1.indextype)),0) as DR_CM_NAFYC
,coalesce((select sum(amount) from labonusproductiondata t1 where wageno=a.bakmonth and agentcode=a.agentcode and indextype in ('01','11') and bonustype='FP_MF' and bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or b.plantype in ('1','2','3','4') then '' else 'IDR_NAFYC' end) and not exists (select top 1 1 from labonusproductiondata where wageno=t1.wageno and indextype in ('01','11') and indextype>t1.indextype)),0) as IDR_CM_NAFYC
,coalesce((select sum(amount) from labonusproductiondata t1 where wageno=a.bakmonth and agentcode=a.agentcode and indextype in ('01','11') and bonustype='FP_MF' and bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') then 'TREE_NAFYC' else '' end) and not exists (select top 1 1 from labonusproductiondata where wageno=t1.wageno and indextype in ('01','11') and indextype>t1.indextype)),0) as TREE_CM_NAFYC
--,coalesce((select sum(amount) from labonusproductiondata t1 where wageno>=b.financestartmonth and wageno<=a.bakmonth and agentcode=a.agentcode and indextype in ('01','11') and bonustype='FP_MF' and ((bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or b.plantype in ('1','2','3','4') then 'P_NAFYC' else 'P_NAFYC_NoOwnPolicy' end)) or (bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or b.plantype in ('1','2','3','4') then '' else 'DR_NAFYC' end)) or (bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or b.plantype in ('1','2','3','4') then '' else 'IDR_NAFYC' end)) or (bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') then 'TREE_NAFYC' else '' end))) and not exists (select top 1 1 from labonusproductiondata where wageno=t1.wageno and indextype in ('01','11') and indextype>t1.indextype)),0) as Total_CTM_NAFYC
--,coalesce((select sum(amount) from labonusproductiondata t1 where wageno>=(select min(yearmonth) from laagentfpdetail where agentcode=a.agentcode and yearmonth>=b.financestartmonth and yearmonth<=b.financeendmonth and financeperiod=c.financeperiod) and wageno<=a.bakmonth and agentcode=a.agentcode and indextype in ('01','11') and bonustype='FP_MF' and ((bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or b.plantype in ('1','2','3','4') then 'P_NAFYC' else 'P_NAFYC_NoOwnPolicy' end)) or (bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or b.plantype in ('1','2','3','4') then '' else 'DR_NAFYC' end)) or (bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or b.plantype in ('1','2','3','4') then '' else 'IDR_NAFYC' end)) or (bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') then 'TREE_NAFYC' else '' end))) and not exists (select top 1 1 from labonusproductiondata where wageno=t1.wageno and indextype in ('01','11') and indextype>t1.indextype)),0) as Period_CTM_NAFYC
,coalesce((select top 1 (case datatype when 'N2' then n2 when 'N4' then n4 when 'N6' then n6 else 0 end) from lrindexinfo where wageno=a.bakmonth and agentcode=a.agentcode and indextype in ('01','11') and indexcode=(case b.plantype when '1' then 'R000000083' when '2' then 'R000000088' when '3' then  'R000000099' when '4' then 'R000000188' when '6' then 'R000000180' when '8' then 'R000000193' end) order by indextype desc),0) as CM_Payment 
--,coalesce((select  sum((case datatype when 'N2' then n2 when 'N4' then n4 when 'N6' then n6 else 0 end)) from lrindexinfo g where  wageno>=b.financestartmonth and wageno <= b.financeendmonth and wageno <= c.yearmonth and agentcode=a.agentcode and  not exists (select top 1 1 from lrindexinfo where wageno=g.wageno and indextype in ('01','11') and indextype>g.indextype)   and  indexcode=(case b.plantype when '1' then 'R000000083' when '2' then 'R000000088' when '3' then  'R000000099' when '4' then 'R000000188' when '6' then 'R000000180' when '8' then 'R000000193' end)),0) as CTM_Payment 
from laagentc a,laagentfp b,laagentfpdetail c 
where a.agentcode=b.agentcode and a.bakmonth=c.yearmonth and b.agentcode=c.agentcode 
and b.financestartmonth<=c.yearmonth and b.financeendmonth>=c.yearmonth and b.plantype in ('1','2','3','4','6','8')  
and C.AGENTCODE='MET000047'  and c.yearmonth>='201503'  and c.yearmonth<='201802' 
order by a.agentcode,c.yearmonth


select tt.financeperiod
,tt.yearmonth
,tt.monthlyfinance
,(select sum(monthlyfinance) from laagentfpdetail where agentcode=tt.agentcode and yearmonth>=tt.financestartmonth and yearmonth<=tt.yearmonth) as CTM_MF
,tt.welcomeincentive
,tt.monthlyfinanceadvance
,tt.validationreq
,(select sum(validationreq) from laagentfpdetail where agentcode=tt.agentcode and yearmonth>=tt.periodstartmonth and yearmonth<=tt.yearmonth) as Period_CTM_Req
,coalesce((select sum(amount) from labonusproductiondata t1 where wageno=tt.yearmonth and agentcode=tt.agentcode and bonustype='FP_MF' and bonussubtype in ('P_NAFYC','P_NAFYC_NoOwnPolicy') and bonussubtype in (select * from dbo.fn_split(tt.subtype,',')) and not exists (select 1 from labonusproductiondata where wageno=t1.wageno and indextype>t1.indextype)),0) as P_CM_NAFYC
,coalesce((select sum(amount) from labonusproductiondata t1 where wageno=tt.yearmonth and agentcode=tt.agentcode and bonustype='FP_MF' and bonussubtype in ('DR_NAFYC') and bonussubtype in (select * from dbo.fn_split(tt.subtype,',')) and not exists (select 1 from labonusproductiondata where wageno=t1.wageno and indextype>t1.indextype)),0) as DR_CM_NAFYC
,coalesce((select sum(amount) from labonusproductiondata t1 where wageno=tt.yearmonth and agentcode=tt.agentcode and bonustype='FP_MF' and bonussubtype in ('IDR_NAFYC') and bonussubtype in (select * from dbo.fn_split(tt.subtype,',')) and not exists (select 1 from labonusproductiondata where wageno=t1.wageno and indextype>t1.indextype)),0) as IDR_CM_NAFYC
,coalesce((select sum(amount) from labonusproductiondata t1 where wageno=tt.yearmonth and agentcode=tt.agentcode and bonustype='FP_MF' and bonussubtype in ('TREE_NAFYC') and bonussubtype in (select * from dbo.fn_split(tt.subtype,',')) and not exists (select 1 from labonusproductiondata where wageno=t1.wageno and indextype>t1.indextype)),0) as TREE_CM_NAFYC
,coalesce((select sum(tamount) from (select amount*(case tt.caltype when 'TREE' then (case bonussubtype when 'TREE_NAFYC' then 1 else 0 end) 
  when 'DRIDR' then (case bonussubtype when 'P_NAFYC_NoOwnPolicy' then 1 when 'DR_NAFYC' then 0.25 when 'IDR_NAFYC' then 0.2 else 0 end) 
  when 'Personal' then (case bonussubtype when 'P_NAFYC' then 1 else 0 end) else 0 end) as tamount
  from labonusproductiondata t1 where wageno>=tt.periodstartmonth and wageno<=tt.yearmonth and agentcode=tt.agentcode and bonustype='FP_MF' and bonussubtype in (select * from dbo.fn_split(tt.subtype,',')) and not exists (select top 1 1 from labonusproductiondata where wageno=t1.wageno and indextype>t1.indextype)) t2),0) as Total_CTM_NAFYC
--,coalesce((select sum(amount) from labonusproductiondata t1 where wageno>=tt.periodstartmonth and wageno<=tt.yearmonth and agentcode=tt.agentcode and bonustype='FP_MF' and ((bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or tt.plantype in ('1','2','3','4') then 'P_NAFYC' else 'P_NAFYC_NoOwnPolicy' end)) or (bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or tt.plantype in ('1','2','3','4') then '' else 'DR_NAFYC' end)) or (bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') or tt.plantype in ('1','2','3','4') then '' else 'IDR_NAFYC' end)) or (bonussubtype=(case when agentcode in (select code from ldcode where codetype='MF_TreeProduction') then 'TREE_NAFYC' else '' end))) and not exists (select top 1 1 from labonusproductiondata where wageno=t1.wageno and indextype>t1.indextype)),0) as Period_CTM_NAFYC
from (
select b.plantype,c.monthlyfinance,c.welcomeincentive,c.monthlyfinanceadvance,c.validationreq
,c.financeperiod,c.yearmonth,a.agentcode,b.financestartmonth
,(select min(yearmonth) from laagentfpdetail where agentcode=a.agentcode and financeperiod=c.financeperiod) as periodstartmonth
,(case when a.agentcode in (select code from ldcode where codetype='MF_TreeProduction') then 'P_NAFYC,TREE_NAFYC' when b.plantype in ('1','2','3','4') then 'P_NAFYC' else 'P_NAFYC_NoOwnPolicy,DR_NAFYC,IDR_NAFYC' end) as subtype
,(case when a.agentcode in (select code from ldcode where codetype='MF_TreeProduction') then 'TREE' when b.plantype in ('1','2','3','4') then 'Personal' else 'DRIDR' end) as caltype
from laagentc a,laagentfp b,laagentfpdetail c 
where a.agentcode=b.agentcode and a.bakmonth=c.yearmonth and b.agentcode=c.agentcode 
and a.agentcode='MET000047' 
and b.financestartmonth<=c.yearmonth and b.financeendmonth>=c.yearmonth and b.plantype in ('1','2','3','4','6','8')  
) tt 
order by agentcode,yearmonth



select * from dbo.fn_split('a,b,c',',')

--查询AFI保单
select mainpolno,commision,trxcode,calculationdate,agentcode1 from lacommision a 
where mainpolno in 
(select mainpolno from lacommision where trxcode='T607') 
and instalmentno=1 
and exists (select 1 from lacommision where mainpolno=a.mainpolno and instalmentno=1 and agentcode1<>a.agentcode1)
order by mainpolno,calculationdate

select id,name,datatype,calsql from lrterm

select wageno,state
,(case when exists (select top 1 1 from lrindexinfo where wageno=a.wageno and indextype='11') then '11' else '01' end) as WageIndexType 
from lawagehistory a where state in ('14','21') order by wageno desc

--SQL Server缓存清除-------------------------------------------------------------------------------
--下面的命令只能清除内存中的缓存信息，并不能实际释放内存，所以从资源管理器看到的内存还是很大
--
--清除存储过程缓存
DBCC FREEPROCCACHE
--注：方便记住关键字 FREEPROCCACHE 可以拆解成 FREE(割舍，清除) PROC（存储过程关键字简写），CACHE（缓存）
 
--清除会话缓存
DBCC FREESESSIONCACHE
--注： FREE(割舍，清除) SESSION（会话） CACHE（缓存）

--清除系统缓存
DBCC FREESYSTEMCACHE('All')
--注：FREE  SYSTE MCACHE  

--清除所有缓存
DBCC DROPCLEANBUFFERS
--注： DROP CLEAN BUFFERS


SELECT mg.session_id, mg.requested_memory_kb, mg.granted_memory_kb, mg.used_memory_kb, t.text, qp.query_plan 
FROM sys.dm_exec_query_memory_grants AS mg
CROSS APPLY sys.dm_exec_sql_text(mg.sql_handle) AS t
CROSS APPLY sys.dm_exec_query_plan(mg.plan_handle) AS qp
ORDER BY 1 DESC OPTION (MAXDOP 1)


--for xml path
select * from lrdroolsrule for xml path('LRDroolsRuleNode')
select * from lrdroolsloaddata for xml path('LRDroolsLoadData')

