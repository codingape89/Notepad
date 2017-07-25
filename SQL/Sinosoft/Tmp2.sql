select * from LM01_ICompanyToChannel
select * from LM14_AgentGradeToAgentTitle

select * from LAManageCom

delete from LAInsuranceCompany;
insert into LAInsuranceCompany values (null,'MetLifeHK','MetLife HongKong','','init',curdate(),curtime(),curdate(),curtime());
insert into LAInsuranceCompany values (null,'MetLifeChina','中美联泰大都会（中国）','','init',curdate(),curtime(),curdate(),curtime());
insert into LAInsuranceCompany values (null,'Cigna','招商信诺','','init',curdate(),curtime(),curdate(),curtime());
insert into LAInsuranceCompany values (null,'PRLife','珠江人寿','','init',curdate(),curtime(),curdate(),curtime());
select * from LAInsuranceCompany

truncate table LAChannel;
insert into LAChannel values (0,'AGY','代理人渠道','','init',curdate(),curtime(),curdate(),curtime());
insert into LAChannel values (0,'BANK','银保渠道','','init',curdate(),curtime(),curdate(),curtime());
insert into LAChannel values (0,'TM','电销渠道','','init',curdate(),curtime(),curdate(),curtime());
select * from LAChannel

delete from LM01_ICompanyToChannel;
insert into LM01_ICompanyToChannel values (1,1,1);
insert into LM01_ICompanyToChannel values (2,2,1);
insert into LM01_ICompanyToChannel values (3,2,2);
insert into LM01_ICompanyToChannel values (4,2,3);
insert into LM01_ICompanyToChannel values (5,3,1);
insert into LM01_ICompanyToChannel values (6,3,2);
insert into LM01_ICompanyToChannel values (7,4,1);
insert into LM01_ICompanyToChannel values (8,4,2);


select date_format(now(),'%Y-%m-%d')
select curdate()

create view V_LM0XInfo as 
select IC.ICompanyID, IC.ICompanyCode, IC.ICompanyName
, LM01.LM01ID
, CN.ChannelID, CN.ChannelCode, CN.ChannelName 
from LAInsuranceCompany IC
left join LM01_ICompanyToChannel LM01 on LM01.ICompanyID=IC.ICompanyID
left join LAChannel CN on LM01.ChannelID=CN.ChannelID
order by IC.ICompanyID, CN.ChannelID

select * from V_LM0XInfo
