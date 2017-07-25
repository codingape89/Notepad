select * from lduser
select * from ldusertomenugrp where usercode='admin';
select * from LRSQLConfig


select * from LAWageHistory
select basic.currentdate from dual
select basic.currenttime from dual

select * from AMS.laagentv
select * from laagentv
select agentgroup,count(distinct(branchlevel)) from labranchgroup group by agentgroup

select http://localhost:8080/BOCGLHK_CMS_DEV/indexlis.jsp 
select a.branchattr,a.branchname,(select hierarchyname from lagrouplevel where level=a.branchlevel),a.branchmanager, (select agentname from laagentv where agentcode=a.branchmanager),a.DirectFlag, a.BranchEffDate,(select ccms.getCodeName(codetype,code, 'en') from ldcode where codetype='RegStatus' and code=a.branchstatus),a.BranchTerminateEffDate, a.Operator,a.ModifyDate from labranchgroup a where 1=1 order by branchlevel Desc,modifydate desc,modifytime desc

select * from ladimission

select table_name from user_tables where NUM_ROWS=0;

select 'alter table '||table_name||' allocate extent;' from user_tables where num_rows=0

select count(1) from laindexinfov

Select Content,Element From LRSQLConfig Where SqlId='insertlRindexinfo' Order By Grade


select * from lrterm order by id

select * from larelationship

select * from larelationshipc

select * from laagentc

delete from laagentc where wageno='201707' and monthtype='02' and branchtype='31' and managecom like 'HK0501%' 
insert into laagentc select DISTINCT '201707','02','1',a.agentcode,a.branchtype,a.agentgroup,a.managecom,a.password,a.lisagentstate,a.agentstate,a.surname,a.givenname,a.englishname,a.hkidname,a.chinesename,a.idtype,a.idno,a.workingvisa,a.workingvisaexpirydate,a.workingvisatype,a.qualification,a.contracttype,a.contracteffdate,a.contractstatus,a.recruitmentprofile,a.recruitingagentcode,a.referringagentcode,a.lastterminationdate,a.lastterminationreason,a.terminationno,a.paymentmethod,a.bankaccountname,a.bankaccountno,a.withheldreason,a.guarantoragentcode,a.guarantoragentrelation,a.guarantortype,a.sex,a.title,a.nationality,a.birthday,a.workingexperience,a.lastjob,a.lastjobserviceyears,a.insuranceexperience,a.insuranceexperienceyears,a.educationlevel,a.addresstype,a.addressroom,a.addressfloor,a.addressblock,a.addressbuilding,a.addressstreet,a.addressdistrict,a.freeaddress,a.phone,a.mobile,a.email,a.companyemail,a.officeaddress,a.officetel,a.officefaxno,a.marriage,a.spousename,a.spouseidno,a.flag1,a.flag2,a.flag3,a.lastjobnature,a.staffcode,a.state,a.sources,a.lastname,a.firstname,a.degree,a.graduateschool,a.experience,a.institute,a.hometel,a.name,a.source,b.agentgrade,b.gradestartdate,b.agentsubgrade,b.subgradestartdate,b.effectivedate,b.transfereffectivedate,b.areacode,b.branchcode,b.upagent,b.selgrouppolflag,b.probationflag,b.probationenddate,b.prepositivedate,b.positiveflag,b.nextpositivedate,b.proxyflag,b.agentsproperty,b.contractsigndate,b.contractenddate,b.preoutworkdate,b.outworkdate,b.productiondate,b.staffdepartment,b.assesor,b.assessdate,b.assesstime,b.agencyflag,b.agencydate,b.agentseries,b.introagency,b.introcommstart,b.employgrade,b.branchno,b.currentagency,c.branchattr,c.branchlevel,c.branchname,c.branchnameeng,c.branchnamechi,c.brancheffdate,c.branchaddress,c.branchphoneno,c.branchfaxno,c.branchlocation,c.branchstatus,c.branchterminateeffdate,c.branchterminatereason,c.directflag,c.upagentgroup,c.branchmanager,c.branchmanagername,c.reportingmanager,c.agentcom,c.channelsource,c.grouptype,c.channeltype ,'WageDailyCal',basic.currentdate, basic.currenttime, basic.currentdate, basic.currenttime FROM laagent a  ,LATree b ,LABranchGroup c WHERE a.agentcode = b.AgentCode  and a.agentgroup = c.AgentGroup  and a.ManageCom like 'HK0501%' and a.BranchType='31' AND EXISTS (select 1 FROM LAStatSegment WHERE YearMonth='201707' AND StatType='01' AND enddate >= a.contracteffdate) ;
delete from larelationshipc where BACKUPMONTH='201707' and BACKTYPE='02' 
insert into larelationshipc select '201707', '02', a.*, 'WageDailyCal', basic.currentdate, basic.currenttime from larelationship a where a.ManageCom LIKE 'HK0501%' AND a.State <> '0' AND EXISTS (select 1 FROM LAStatSegment WHERE YearMonth='201707' AND StatType='01' AND enddate >= (select ContractEffDate FROM LAAgent WHERE BranchType='31' and  AgentCode = a.agentcode and rownum <= 1 ))

select * from LAStatSegment where yearmonth='201707'

delete from laagentc where wageno='201707' and monthtype='02' and branchtype='31' and managecom like 'HK%' 
insert into laagentc select DISTINCT '201707','02','1',a.agentcode,a.branchtype,a.agentgroup,a.managecom,a.password,a.lisagentstate,a.agentstate,a.surname,a.givenname,a.englishname,a.hkidname,a.chinesename,a.idtype,a.idno,a.workingvisa,a.workingvisaexpirydate,a.workingvisatype,a.qualification,a.contracttype,a.contracteffdate,a.contractstatus,a.recruitmentprofile,a.recruitingagentcode,a.referringagentcode,a.lastterminationdate,a.lastterminationreason,a.terminationno,a.paymentmethod,a.bankaccountname,a.bankaccountno,a.withheldreason,a.guarantoragentcode,a.guarantoragentrelation,a.guarantortype,a.sex,a.title,a.nationality,a.birthday,a.workingexperience,a.lastjob,a.lastjobserviceyears,a.insuranceexperience,a.insuranceexperienceyears,a.educationlevel,a.addresstype,a.addressroom,a.addressfloor,a.addressblock,a.addressbuilding,a.addressstreet,a.addressdistrict,a.freeaddress,a.phone,a.mobile,a.email,a.companyemail,a.officeaddress,a.officetel,a.officefaxno,a.marriage,a.spousename,a.spouseidno,a.flag1,a.flag2,a.flag3,a.lastjobnature,a.staffcode,a.state,a.sources,a.lastname,a.firstname,a.degree,a.graduateschool,a.experience,a.institute,a.hometel,a.name,a.source,b.agentgrade,b.gradestartdate,b.agentsubgrade,b.subgradestartdate,b.effectivedate,b.transfereffectivedate,b.areacode,b.branchcode,b.upagent,b.selgrouppolflag,b.probationflag,b.probationenddate,b.prepositivedate,b.positiveflag,b.nextpositivedate,b.proxyflag,b.agentsproperty,b.contractsigndate,b.contractenddate,b.preoutworkdate,b.outworkdate,b.productiondate,b.staffdepartment,b.assesor,b.assessdate,b.assesstime,b.agencyflag,b.agencydate,b.agentseries,b.introagency,b.introcommstart,b.employgrade,b.branchno,b.currentagency,c.branchattr,c.branchlevel,c.branchname,c.branchnameeng,c.branchnamechi,c.brancheffdate,c.branchaddress,c.branchphoneno,c.branchfaxno,c.branchlocation,c.branchstatus,c.branchterminateeffdate,c.branchterminatereason,c.directflag,c.upagentgroup,c.branchmanager,c.branchmanagername,c.reportingmanager,c.agentcom,c.channelsource,c.grouptype,c.channeltype ,'WageDailyCal',basic.currentdate, basic.currenttime, basic.currentdate, basic.currenttime FROM laagent a  ,LATree b ,LABranchGroup c WHERE a.agentcode = b.AgentCode  and a.agentgroup = c.AgentGroup  and a.ManageCom like 'HK%' and a.BranchType='31' AND EXISTS (select 1 FROM LAStatSegment WHERE YearMonth='201707' AND StatType='01' AND enddate >= a.contracteffdate) ;
delete from larelationshipc where BACKUPMONTH='201707' and BACKTYPE='02' 
insert into larelationshipc select '201707', '02', a.*, 'WageDailyCal', basic.currentdate, basic.currenttime from larelationship a where a.ManageCom LIKE 'HK%' AND a.State <> '0' AND EXISTS (select 1 FROM LAStatSegment WHERE YearMonth='201707' AND StatType='01' AND enddate >= (select ContractEffDate FROM LAAgent WHERE BranchType='31' and  AgentCode = a.agentcode and rownum <= 1 ))

insert into laagentc select DISTINCT '201707','02','1',a.agentcode,a.branchtype,a.agentgroup,a.managecom,a.password,a.lisagentstate,a.agentstate,a.surname,a.givenname,a.englishname,a.hkidname,a.chinesename,a.idtype,a.idno,a.workingvisa,a.workingvisaexpirydate,a.workingvisatype,a.qualification,a.contracttype,a.contracteffdate,a.contractstatus,a.recruitmentprofile,a.recruitingagentcode,a.referringagentcode,a.lastterminationdate,a.lastterminationreason,a.terminationno,a.paymentmethod,a.bankaccountname,a.bankaccountno,a.withheldreason,a.guarantoragentcode,a.guarantoragentrelation,a.guarantortype,a.sex,a.title,a.nationality,a.birthday,a.workingexperience,a.lastjob,a.lastjobserviceyears,a.insuranceexperience,a.insuranceexperienceyears,a.educationlevel,a.addresstype,a.addressroom,a.addressfloor,a.addressblock,a.addressbuilding,a.addressstreet,a.addressdistrict,a.freeaddress,a.phone,a.mobile,a.email,a.companyemail,a.officeaddress,a.officetel,a.officefaxno,a.marriage,a.spousename,a.spouseidno,a.flag1,a.flag2,a.flag3,a.lastjobnature,a.staffcode,a.state,a.sources,a.lastname,a.firstname,a.degree,a.graduateschool,a.experience,a.institute,a.hometel,a.name,a.source,b.agentgrade,b.gradestartdate,b.agentsubgrade,b.subgradestartdate,b.effectivedate,b.transfereffectivedate,b.areacode,b.branchcode,b.upagent,b.selgrouppolflag,b.probationflag,b.probationenddate,b.prepositivedate,b.positiveflag,b.nextpositivedate,b.proxyflag,b.agentsproperty,b.contractsigndate,b.contractenddate,b.preoutworkdate,b.outworkdate,b.productiondate,b.staffdepartment,b.assesor,b.assessdate,b.assesstime,b.agencyflag,b.agencydate,b.agentseries,b.introagency,b.introcommstart,b.employgrade,b.branchno,b.currentagency,c.branchattr,c.branchlevel,c.branchname,c.branchnameeng,c.branchnamechi,c.brancheffdate,c.branchaddress,c.branchphoneno,c.branchfaxno,c.branchlocation,c.branchstatus,c.branchterminateeffdate,c.branchterminatereason,c.directflag,c.upagentgroup,c.branchmanager,c.branchmanagername,c.reportingmanager,c.agentcom,c.channelsource,c.grouptype,c.channeltype ,'WageDailyCal',basic.currentdate, basic.currenttime, basic.currentdate, basic.currenttime FROM laagent a  ,LATree b ,LABranchGroup c WHERE a.agentcode = b.AgentCode  and a.agentgroup = c.AgentGroup  and a.ManageCom like 'HK%' and a.BranchType='31' AND EXISTS (select 1 FROM LAStatSegment WHERE YearMonth='201707' AND StatType='01' AND enddate >= a.contracteffdate) ;

select * from LAAgentAdjustC

select * from LRBonusSub
select * from Laassessaccessorytrial

LaindexinfoM LaindexinfoN Laassessaccessorytrial
//   LaagentC
//   Lrindexinfo
//   LaindexinfoV
//   LaindexinfoM
//   LaindexinfoN
//   LaindexinfoA
//   LabonusSub
//   LaagentadjustC
//   Laassessaccessorytrial 

select * from ldcode where codetype = 'BaseCode'

select * from laindexinfov
select distinct wagedate from laindexinfod order by wagedate desc

select * from lawagehistory where wageno='201702';

SELECT state FROM LAWageHistory WHERE WageNo='201702' AND Monthtype = '02' AND BranchType = '31' AND ManageCom like ''

select * from laagentc where wageno='201702' and monthtype='02' and branchtype='31' and managecom like 'HK%' 
select * from larelationshipc where BACKUPMONTH='201702' and BACKTYPE='02' 

select * from laagentgrade order by gradecode

select * from lduser
