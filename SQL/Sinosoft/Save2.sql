select * from lawagehistory order by wageno desc;

select B.WageNo, B.WageName, B.IndexCode, B.AgentCode, B.DataType, 
(case B.DataType when 'D' then (convert(varchar, B.D, 120)) when 'N0' then B.N0 when 'N2' then B.N2 when 'N4' then B.N4 else B.N6 end) as Data_B,
(case A.DataType when 'D' then (convert(varchar, A.D, 120)) when 'N0' then A.N0 when 'N2' then A.N2 when 'N4' then A.N4 else A.N6 end) as Data_A 
from lrindexinfo_20170706 B, lrindexinfo A 
where A.AgentCode = B.AgentCode and A.IndexCode = B.IndexCode and A.INDEXTYPE=B.INDEXTYPE and A.WageNo = B.WageNo 
and B.wageno = '201703' and B.IndexType = '01' 
and a.indexcode like 'I%' 
and (A.D <> B.D or A.N0 <> B.N0 or A.N2 <> B.N2 or A.N4 <> B.N4 or A.N6 <> B.N6) 
order by B.indexcode,B.agentcode

--and a.indexcode in ('I000000066','I000000065','I000000068','I000000069','I000000070','I000000192') 
--and a.agentcode='MET001072'



select * from (
select agentcode,b.yearmonth 
,(select amount from labonusproductiondata where branchtype='1' and bonustype='FP_MF' and bonussubtype='P_NAFYC' and wageno=b.yearmonth and indextype='01' and agentcode=a.agentcode) as amount01
,(select amount from labonusproductiondata where branchtype='1' and bonustype='FP_MF' and bonussubtype='P_NAFYC' and wageno=b.yearmonth and indextype='11' and agentcode=a.agentcode) as amount11 
from laagentfp a,lastatsegment b 
where plantype='1' and financestartmonth<='201702' and financeendmonth>='201702' 
and a.financestartmonth<=b.yearmonth and '201702'>b.yearmonth 
and a.agentcode='MET001072' 
) tt where amount01 is not null and amount11 is not null 
and amount01<>amount11 
order by agentcode,yearmonth



select * from (
select agentcode,b.yearmonth 
,(select S from lrindexinfo where wageno=b.yearmonth and indextype='01' and branchtype='1' and branchtype2='1' and basecode='B00001' and indexcode='I000000014' and agentcode=a.agentcode) as amount01
,(select S from lrindexinfo where wageno=b.yearmonth and indextype='11' and branchtype='1' and branchtype2='1' and basecode='B00001' and indexcode='I000000014' and agentcode=a.agentcode) as amount11 
from laagentfp a,lastatsegment b 
where plantype='1' and financestartmonth<='201702' and financeendmonth>='201702' 
and a.financestartmonth<=b.yearmonth and '201702'>b.yearmonth 
and a.agentcode='MET001072' 
) tt where amount01 is not null and amount11 is not null 
and amount01<>amount11 
order by agentcode,yearmonth