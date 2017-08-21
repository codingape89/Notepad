----查看菜单结构-------------------------------
select a.nodecode,a.nodename,a.nodeorder,(case when a.childflag=0 then 'Y' when a.childflag>0 then 'N' else null end)
,b.nodecode,b.nodename,b.nodeorder,(case when b.childflag=0 then 'Y' when b.childflag>0 then 'N' else null end)
,c.nodecode,c.nodename,c.nodeorder,(case when c.childflag=0 then 'Y' when c.childflag>0 then 'N' else null end)
,d.nodecode,d.nodename,d.nodeorder,(case when d.childflag=0 then 'Y' when d.childflag>0 then 'N' else null end)
,e.nodecode,e.nodename,e.nodeorder,(case when e.childflag=0 then 'Y' when e.childflag>0 then 'N' else null end)
,f.nodecode,f.nodename,f.nodeorder,(case when f.childflag=0 then 'Y' when f.childflag>0 then 'N' else null end) 
from ldmenu a 
left join ldmenu b on a.nodecode=b.parentnodecode 
left join ldmenu c on b.nodecode=c.parentnodecode 
left join ldmenu d on c.nodecode=d.parentnodecode 
left join ldmenu e on d.nodecode=e.parentnodecode 
left join ldmenu f on e.nodecode=f.parentnodecode 
where a.parentnodecode='0' 
order by a.nodeorder,b.nodeorder,c.nodeorder,d.nodeorder,e.nodeorder,f.nodeorder;
----查看菜单结构-------------------------------

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

----Start LAAgentD Backup-------------------------------
insert into laagentd 
select '2017-08-07',a.managecom,a.branchtype,a.agentcode,a.agentname,
a.agentgroup,a.branchattr,a.directflag,a.contracttype,a.contracteffdate,
a.contractstatus,a.agentstate,a.outworkdate,a.agentgrade,a.gradestartdate,
a.unitagentgroup,a.unitbranchattr,a.unitmanagercode,
a.divisionagentgroup,a.divisionbranchattr,a.divisionmanagercode,
a.regionagentgroup,a.regionbranchattr,a.regionmanagercode,
'bg',dbo.currentdate(),dbo.currenttime(),dbo.currentdate(),dbo.currenttime(),
b.leader1st,b.leader2nd,b.leader3rd,b.leader4th,b.leader5th,
b.leader6th,b.leader7th,b.leader8th,b.leader9th,b.leader10th,
a.referringagentcode,a.recruitingagentcode 
from laagentv a left join larelationshipv b 
on a.agentcode=b.agentcode and b.type='1' 
where 1=1 
----End LAAgentD Backup-------------------------------

