select a.wageno, a.indextype, a.bonustype, a.bonussubtype, a.wageno, a.agentcode, a.amount, c.downlineagentcode, b.downlineamount, c.policyno, c.productionsn, c.productionamount 
from labonusproductiondata a 
inner join labonusrelationtodldata b on a.bonusproductionsn = b.bonusproductionsn
inner join labonusproductiondlpolicydata c on b.bonusproductiondlsn = c.bonusproductiondlsn
where --a.agentcode = 'MET001542'
--and a.wageno between '201607' and '201609' and a.bonustype = 'FP_MF' and a.indextype = '11' and
a.wageno = '201701'
order by agentcode, a.bonustype, a.bonussubtype, c.downlineagentcode, c.policyno, a.wageno


select * from lrterm where id in ('I000000145','I000000146','I000000147');

select * from LAAFYC