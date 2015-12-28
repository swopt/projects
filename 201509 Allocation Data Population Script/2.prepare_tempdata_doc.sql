-- drop if exist temp table and create temp table tempdocalloc
if (OBJECT_ID('tempdocalloc','U') is not null) drop table tempdocalloc;
create table tempdocalloc (
	allocid int identity(1,1),
	allocationtype varchar(4), allocatedfromid int, allocatedfromentryno int,
	allocatedtoid int, allocatedtoentryno int,
	allocationentryno int,allocationdate datetime,
	allocateddebit decimal(18,4), allocatedcredit decimal(18,4),allowmodify char,
	tran_id_to int
)	

declare @docid char(15)
declare @docidto char(15)
declare @allocentryno char(15)
declare @amtpaying decimal(18,4)
select @docid = min(doc_id) from doc_alloc_detail

declare @tempbatch table(
	row int,
	batch int,
	amt decimal(18,4)
)
-- iterate through each doc_alloc_detail.doc_id
while @docid is not null
begin
	select @allocentryno = min(alloc_entry_no) from doc_alloc_detail where doc_id = @docid
	declare @maxentry int
	select @maxentry = isnull(max(allocatedfromentryno),0) from tempdocalloc where allocatedfromid = @docid
	declare @countEntNoA0 int
	select @countEntNoA0 = count(*) from doc_detail where doc_id=@docid and entry_no_a0>1
	declare @allocdate datetime
	select @allocdate=min(doc_dt_lastupdate) from doc_security where doc_id=@docid 
	declare @count int
	declare @batchrow int
	
	
	
	--iterate through each doc_detail.entry_no_a0 for each doc_alloc_detail.doc_id
	while @allocentryno is not null
	begin
		
		select @docidto=doc_id_to, @amtpaying=allocl_amt_paying from doc_alloc_detail
		where doc_id = @docid and alloc_entry_no = @allocentryno
		declare @alloctoentno int
		select @alloctoentno=min(entry_no_a0) from doc_detail where doc_id=@docidto
		
		--get allocationtype
		declare @alloctype varchar(4)
		select @alloctype= cast(at.allocation_type as varchar(4)) from allocation_type_rules_v at
		join doc_header dhfrom
		on at.tran_type_from = dhfrom.doc_category
		join doc_header dhto
		on at.tran_type_to = dhto.doc_category
		where dhfrom.doc_id = @docid and dhto.doc_id = @docidto
		
		
		-- populate entries where entrydebit>0 and entrycredit=0
		delete from @tempbatch
		select @count = count(*) from GetBatchAmounts(@amtpaying,@docid,@maxentry,'DEBIT')
		if (@count > 0)
		BEGIN
		insert into @tempbatch select * from GetBatchAmounts(@amtpaying,@docid,@maxentry,'DEBIT')
		insert into tempdocalloc(allocationtype,allocatedfromid,allocatedtoid,
			allocatedfromentryno,allocatedtoentryno,allocationdate,
			allocateddebit,allocatedcredit)
			select @alloctype,@docid,@docid,batch,batch,@allocdate,0,amt from @tempbatch
		insert into tempdocalloc(allocationtype,allocatedfromid,allocatedtoid,
			allocatedfromentryno,allocatedtoentryno,allocationdate,
			allocateddebit,allocatedcredit)
			select @alloctype,@docid,@docidto,batch,@alloctoentno,@allocdate,amt,0 from @tempbatch
		END
		
		-- populate entries where entrydebit=0 and entrycredit>0
		delete from @tempbatch
		select @count = count(*) from GetBatchAmounts(@amtpaying,@docid,@maxentry,'CREDIT')
		if (@count > 0)
		BEGIN
		insert into @tempbatch select * from GetBatchAmounts(@amtpaying,@docid,@maxentry,'CREDIT')
		insert into tempdocalloc(allocationtype,allocatedfromid,allocatedtoid,
			allocatedfromentryno,allocatedtoentryno,allocationdate,
			allocatedcredit,allocateddebit)
			select @alloctype,@docid,@docid,batch,batch,@allocdate,0,amt from @tempbatch
		insert into tempdocalloc(allocationtype,allocatedfromid,allocatedtoid,
			allocatedfromentryno,allocatedtoentryno,allocationdate,
			allocatedcredit,allocateddebit)
			select @alloctype,@docid,@docidto,batch,@alloctoentno,@allocdate,amt,0 from @tempbatch
		END
		if(@countEntNoA0>0) select @maxentry = isnull(max(allocatedfromentryno),0) from tempdocalloc where allocatedfromid = @docid
		select @allocentryno = min(alloc_entry_no) from doc_alloc_detail where doc_id = @docid and alloc_entry_no > @allocentryno
		
	end
	
	-- update allocationentryno
	declare @tmpallocid int
	declare @tmpallocentno int
	set @tmpallocentno = 1
	select @tmpallocid = min(allocid) from tempdocalloc where allocatedfromid=@docid
	while @tmpallocid is not null
	begin
		update tempdocalloc set allocationentryno=@tmpallocentno where allocatedfromid=@docid and allocid=@tmpallocid
		set @tmpallocentno = @tmpallocentno+1
		select @tmpallocid = min(allocid) from tempdocalloc where allocatedfromid=@docid and allocid>@tmpallocid
	end
	
	-- set @docid to next doc_id
	select @docid = min(doc_id) from doc_alloc_detail where doc_id > @docid
	
end

--select allocatedfromid,count(*) as nrow from tempdocalloc where allocatedfromentryno>1 group by allocatedfromid  order by allocatedfromid
--select * from tempdocalloc order by allocatedfromid,allocatedfromentryno
--select * from tempdocalloc where allocatedfromid = 822239

