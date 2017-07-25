select * from (
select mainpolno,agentcode1,agentstate1,aplitrate
,(case when agentstate1='01' and agentstate2='03' then 1 else splitrate1 end) as splitrate1a
,agentcode2,agentstate2
,(case when agentstate2='01' and agentstate1='03' then 1 else splitrate2 end) as splitrate2a 
from (
select mainpolno
,coalesce(agentcode1,'') as agentcode1,splitrate1
,coalesce((select agentstate from laagent where agentcode=lccont.agentcode1),'') as agentstate1
,coalesce(agentcode2,'') as agentcode2,splitrate2
,coalesce((select agentstate from laagent where agentcode=lccont.agentcode2),'') as agentstate2 
from lccont) lccont1) tt
where 


select mainpolno
,coalesce(agentcode1,'') as agentcode1,splitrate1
,coalesce((select agentstate from laagent where agentcode=lccont.agentcode1),'') as agentstate1
,coalesce(agentcode2,'') as agentcode2,splitrate2
,coalesce((select agentstate from laagent where agentcode=lccont.agentcode2),'') as agentstate2 

select * from (
create view LCContV_SplirtateFix as 
select mainpolno,agentcode1,agentstate1,outworkdate1,originalrate1
,(case when agentstate1='01' and agentstate2='03' then 1 when agentstate1='03' and agentstate2='01' then 0 else originalrate1 end) as fixrate1
,agentcode2,agentstate2,outworkdate2,originalrate2
,(case when agentstate1='03' and agentstate2='01' then 1 when agentstate1='01' and agentstate2='03' then 0 else originalrate2 end) as fixrate2
from (
select cont.mainpolno,cont.agentcode1,agent1.agentstate as agentstate1,dimission1.outworkdate as outworkdate1,cont.splitrate1 as originalrate1
,cont.agentcode2,agent2.agentstate as agentstate2,dimission2.outworkdate as outworkdate2,cont.splitrate2 as originalrate2 
from lccont cont 
left join laagent agent1 on cont.agentcode1=agent1.agentcode 
left join ladimission dimission1 on cont.agentcode1=dimission1.agentcode
left join laagent agent2 on cont.agentcode2=agent2.agentcode 
left join ladimission dimission2 on cont.agentcode2=dimission2.agentcode
) tt
) tt1 

alter view LCContV_SplirtateFix 
as 
select mainpolno,agentcode1,agentstate1,outworkdate1,splitrate1
,(case when agentstate1='01' and agentstate2='03' then 1 when agentstate1='03' and agentstate2='01' then 0 else splitrate1 end) as fixrate1
,agentcode2,agentstate2,outworkdate2,splitrate2
,(case when agentstate1='03' and agentstate2='01' then 1 when agentstate1='01' and agentstate2='03' then 0 else splitrate2 end) as fixrate2
from (
select cont.mainpolno,cont.agentcode1,agent1.agentstate as agentstate1,dimission1.outworkdate as outworkdate1,cont.splitrate1
,cont.agentcode2,agent2.agentstate as agentstate2,dimission2.outworkdate as outworkdate2,cont.splitrate2 
from lccont cont 
left join laagent agent1 on cont.agentcode1=agent1.agentcode 
left join ladimission dimission1 on cont.agentcode1=dimission1.agentcode
left join laagent agent2 on cont.agentcode2=agent2.agentcode 
left join ladimission dimission2 on cont.agentcode2=dimission2.agentcode
) tt


select * from LCContV where splitrate1<>fixrate1 or splitrate2<>fixrate2

create view LCContV 
as 
select mainpolno,agentcode1,agentstate1,outworkdate1,splitrate1
,(case when agentstate1='01' and agentstate2='03' then 1 when agentstate1='03' and agentstate2='01' then 0 else splitrate1 end) as fixrate1
,agentcode2,agentstate2,outworkdate2,splitrate2
,(case when agentstate1='03' and agentstate2='01' then 1 when agentstate1='01' and agentstate2='03' then 0 else splitrate2 end) as fixrate2
from (
select cont.mainpolno,cont.agentcode1,agent1.agentstate as agentstate1,dimission1.outworkdate as outworkdate1,cont.splitrate1
,cont.agentcode2,agent2.agentstate as agentstate2,dimission2.outworkdate as outworkdate2,cont.splitrate2 
from lccont cont 
left join laagent agent1 on cont.agentcode1=agent1.agentcode 
left join ladimission dimission1 on cont.agentcode1=dimission1.agentcode
left join laagent agent2 on cont.agentcode2=agent2.agentcode 
left join ladimission dimission2 on cont.agentcode2=dimission2.agentcode
) tt


select * from msysvar