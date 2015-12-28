if (OBJECT_ID('temptranalloc','U') is not null) drop table temptranalloc;
create table temptranalloc (
	allocid int identity(1,1),
	allocationtype varchar(4), allocatedfromid int, allocatedfromentryno int,
	allocatedtoid int, allocatedtoentryno int,
	allocationentryno int,allocationdate datetime,
	allocateddebit decimal(18,4), allocatedcredit decimal(18,4),allowmodify char
)

insert into temptranalloc(
	allocationtype,allocatedfromid,allocatedfromentryno,
	allocatedtoid,allocatedtoentryno,allocationentryno,
	allocationdate,allocateddebit,allocatedcredit,allowmodify
) select 
	allocationtype, allocatedfromid,allocatedfromentryno,
	allocatedtoid, allocatedtoentryno, allocationentryno,
	allocationdate,allocateddebit,allocatedcredit,allowmodify
from tempdocalloc

declare @allocid char(15)
select @allocid = min(allocid) from tempdocalloc
declare @tranidfr int
declare @tranidto int

while @allocid is not null
begin
	select top 1 @tranidfr=dde.tran_id from doc_dist_entry_v dde 
	join allocation_type_rules_v atr
	on dde.subs_code = atr.ledger_type
	join temptranalloc tmp
	on dde.doc_id2=tmp.allocatedfromid and dde.doc_entry_no=tmp.allocatedfromentryno and atr.allocation_type=tmp.allocationtype
	where tmp.allocid=@allocid and dde.dist_post_status='POSTED'
	
	select top 1 @tranidto=dde.tran_id from doc_dist_entry_v dde 
	join allocation_type_rules_v atr
	on dde.subs_code = atr.ledger_type_to
	join temptranalloc tmp
	on dde.doc_id2=tmp.allocatedtoid and dde.doc_entry_no=tmp.allocatedtoentryno and atr.allocation_type=tmp.allocationtype
	where tmp.allocid=@allocid and dde.dist_post_status='POSTED'

	if (@tranidfr is not null and @tranidto is not null)
	begin
		update temptranalloc set allocatedfromid=@tranidfr,allocatedtoid=@tranidto
		where allocid=@allocid
	end
	select @allocid = min(allocid) from tempdocalloc where allocid>@allocid
end