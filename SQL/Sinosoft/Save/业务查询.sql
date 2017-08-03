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


