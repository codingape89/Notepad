select tstepno,tbasecode,tagentgrade,tindexcode,tindextype,count(1) 
from Tmp_Table group by tstepno,tbasecode,tagentgrade,tindexcode,tindextype
having count(1)>1


SELECT coalesce(MAX(right(id,8)),'0') FROM LRTERM

update ldmaxno set maxno=CAST((SELECT coalesce(MAX(edorno),'0') FROM LRBASEB) as SIGNED) where notype='LRBASEB';
update ldmaxno set maxno=CAST((SELECT coalesce(MAX(right(id,8)),'0') FROM LRTERM) as SIGNED) where notype='LRTERM';

select * from ldmaxno where notype in ('LRBASEB','LRTERM')

select * from LRAssessIndexLibrary where indexcode in (select indexcode from LRAssessIndex where basecode='B00001' ) 