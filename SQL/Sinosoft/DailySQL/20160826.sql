--Create Procedure
IF EXISTS (select 1 FROM sysobjects WHERE id = object_id('proc_PatchBonusProduction') AND type = 'P')
    drop PROC proc_PatchBonusProduction
GO

--20160826 历史数据只Patch LABonusProductionData一张表即可，保证功能的正常查询，不需要显示到Policy Detail
--CREATE proc [dbo].[proc_PatchBonusProduction](@tIndexCalNo varchar(6),@tIndexType varchar(2),@tBonusType varchar(50),@tBonusSubType varchar(50),@bj1 nvarchar(max) out,@bj2 nvarchar(max) out)
CREATE proc [dbo].[proc_PatchBonusProduction](@tIndexCalNo varchar(6),@tIndexType varchar(2),@tBonusType varchar(50),@tBonusSubType varchar(50))
as
  begin
    declare @tBasicSqlPart1 nvarchar(MAX)
    declare @tBasicSqlPart2 nvarchar(MAX)
    declare @tParaSql nvarchar(MAX)

    declare @tDeleteSql nvarchar(MAX)
    declare @tInsertSql nvarchar(MAX)

    set @tDeleteSql = 'delete from labonusproductiondata where wageno='''+@tIndexCalNo+''' and indextype='''+@tIndexType+''' and bonustype='''+@tBonusType+''' and bonussubtype='''+@tBonusSubType+''''

    set @tBasicSqlPart1 = 'insert into labonusproductiondata '
    set @tBasicSqlPart1 = @tBasicSqlPart1 + 'select branchtype,'''+@tBonusType+''','''+@tBonusSubType+''','''+@tIndexCalNo+''','''+@tIndexType+''',c.agentcode '

    set @tBasicSqlPart2 = ',c.branchtype+''|''+'''+@tBonusType+'''+''|''+'''+@tBonusSubType+'''+''|''+'''+@tIndexCalNo+'''+''|''+'''+@tIndexType+'''+''|''+c.agentcode as tBonusProductionSN '
    set @tBasicSqlPart2 = @tBasicSqlPart2 + ',''patch'' as tOperator '
    set @tBasicSqlPart2 = @tBasicSqlPart2 + ',dbo.currentdate() as tMakeDate '
    set @tBasicSqlPart2 = @tBasicSqlPart2 + ',dbo.currenttime() as tMakeTime '
    set @tBasicSqlPart2 = @tBasicSqlPart2 + ',dbo.currentdate() as tModifyDate '
    set @tBasicSqlPart2 = @tBasicSqlPart2 + ',dbo.currenttime() as tModifyTime '
    set @tBasicSqlPart2 = @tBasicSqlPart2 + 'from laagentc c where bakmonth='''+@tIndexCalNo+''' and baktype=''1'' and branchtype=''1'' '

    if(@tBonusType = 'FP_MF' and @tBonusSubType = 'P_NAFYC')
      set @tParaSql = ',coalesce((select sum(tafyc) from (select afyc*splitrate1 as tafyc from laafyc a where agentcode1=c.agentcode and wagemonth1=c.bakmonth and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode) union all select afyc*splitrate2 as tafyc from laafyc a where agentcode2=c.agentcode and wagemonth2=c.bakmonth and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode)) tt),0) as tAmount'

    if(@tBonusType = 'FP_MF' and @tBonusSubType = 'P_NAFYC_NoOwnPolicy')
      set @tParaSql = ',coalesce((select sum(tafyc) from (select afyc*splitrate1 as tafyc from laafyc a where agentcode1=c.agentcode and wagemonth1=c.bakmonth and dbo.IsOwnPolicy(MainPolNo,agentcode1)=''N'' and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode) union all select afyc*splitrate2 as tafyc from laafyc a where agentcode2=c.agentcode and wagemonth2=c.bakmonth and dbo.IsOwnPolicy(MainPolNo,agentcode2)=''N'' and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode)) tt),0) as tAmount'

    if(@tBonusType = 'FP_MF' and @tBonusSubType = 'DR_NAFYC')
      set @tParaSql = ',coalesce((select sum(tafyc) from (select afyc*splitrate1 as tafyc from laafyc a where drcode1=c.agentcode and wagemonth1=c.bakmonth and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode) union all select afyc*splitrate2 as tafyc from laafyc a where drcode2=c.agentcode and wagemonth2=c.bakmonth and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode)) tt),0) as tAmount'

    if(@tBonusType = 'FP_MF' and @tBonusSubType = 'IDR_NAFYC')
      set @tParaSql = ',coalesce((select sum(tafyc) from (select afyc*splitrate1 as tafyc from laafyc a where idrcode1=c.agentcode and wagemonth1=c.bakmonth and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode) union all select afyc*splitrate2 as tafyc from laafyc a where idrcode2=c.agentcode and wagemonth2=c.bakmonth and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode)) tt),0) as tAmount'

    if(@tBonusType = 'FP_MF' and @tBonusSubType = 'TREE_NAFYC')
      set @tParaSql = ',coalesce((select sum(tafyc) from (select afyc*splitrate1 as tafyc from laafyc a where agentcode1 in (select agentcode from LAAgentHirearchyV where yearmonth=c.bakmonth and topagentcode=c.agentcode) and wagemonth1=c.bakmonth and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode) union all select afyc*splitrate2 as tafyc from laafyc a where agentcode2 in (select agentcode from LAAgentHirearchyV where yearmonth=c.bakmonth and topagentcode=c.agentcode) and wagemonth2=c.bakmonth and exists (select 1 from ldcode where codetype=''TrxCode_NAFYC'' and code=a.trxcode)) tt),0) as tAmount'

    set @tInsertSql = @tBasicSqlPart1 + @tParaSql + @tBasicSqlPart2

    --set @bj1 = @tDeleteSql
    --set @bj2 = @tInsertSql

    set nocount on
      exec sp_executesql @tDeleteSql
      exec sp_executesql @tInsertSql
    set nocount off

  end
go


--Exec Procedure
exec dbo.proc_PatchBonusProduction '201410','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201410','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201410','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201410','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201410','11','FP_MF','TREE_NAFYC'
GO

exec dbo.proc_PatchBonusProduction '201411','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201411','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201411','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201411','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201411','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201412','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201412','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201412','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201412','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201412','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201501','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201501','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201501','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201501','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201501','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201502','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201502','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201502','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201502','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201502','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201503','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201503','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201503','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201503','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201503','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201504','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201504','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201504','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201504','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201504','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201505','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201505','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201505','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201505','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201505','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201506','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201506','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201506','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201506','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201506','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201507','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201507','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201507','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201507','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201507','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201508','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201508','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201508','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201508','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201508','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201509','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201509','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201509','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201509','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201509','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201510','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201510','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201510','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201510','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201510','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201511','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201511','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201511','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201511','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201511','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201512','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201512','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201512','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201512','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201512','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201601','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201601','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201601','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201601','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201601','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201602','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201602','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201602','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201602','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201602','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201603','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201603','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201603','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201603','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201603','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201604','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201604','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201604','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201604','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201604','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201605','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201605','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201605','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201605','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201605','11','FP_MF','TREE_NAFYC'
GO


exec dbo.proc_PatchBonusProduction '201606','11','FP_MF','P_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201606','11','FP_MF','P_NAFYC_NoOwnPolicy'
GO
exec dbo.proc_PatchBonusProduction '201606','11','FP_MF','DR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201606','11','FP_MF','IDR_NAFYC'
GO
exec dbo.proc_PatchBonusProduction '201606','11','FP_MF','TREE_NAFYC'
GO

GO
exec dbo.proc_PatchBonusProduction '201607','01','FP_MF','TREE_NAFYC'
GO

--Check Result
select a.bakmonth,a.agentcode,b.plantype
,(select top 1 (case datatype when 'N2' then n2 when 'N4' then n4 when 'N6' then n6 else 0 end) from lrindexinfo c
  where wageno=a.bakmonth and agentcode=a.agentcode and indextype in ('11','01')
  and indexcode=(case b.plantype when '1' then 'I000000065' when '2' then 'I000000076' when '3' then 'I000000088' when '4' then 'I000000101'
  when '6' then 'I000000139' when '7' then 'I000000241' when '8' then 'I000000220' else '' end) order by indextype desc) as sysvalue
,(select amount from labonusproductiondata where agentcode=a.agentcode and indextype='11' and wageno=a.bakmonth and bonustype='FP_MF' and bonussubtype='P_NAFYC') as patchvalue_p
,(select amount from labonusproductiondata where agentcode=a.agentcode and indextype='11' and wageno=a.bakmonth and bonustype='FP_MF' and bonussubtype='P_NAFYC_NoOwnPolicy') as patchvalue_pn
,(select amount from labonusproductiondata where agentcode=a.agentcode and indextype='11' and wageno=a.bakmonth and bonustype='FP_MF' and bonussubtype='DR_NAFYC') as patchvalue_dr
,(select amount from labonusproductiondata where agentcode=a.agentcode and indextype='11' and wageno=a.bakmonth and bonustype='FP_MF' and bonussubtype='IDR_NAFYC') as patchvalue_idr
,(select amount from labonusproductiondata where agentcode=a.agentcode and indextype='11' and wageno=a.bakmonth and bonustype='FP_MF' and bonussubtype='TREE_NAFYC') as patchvalue_tree
from laagentc a,laagentfp b
where a.agentcode=b.agentcode and a.bakmonth>=b.financestartmonth and a.bakmonth<=b.financeendmonth
and a.bakmonth<='201607' and a.baktype='1'
order by a.bakmonth,a.agentcode
