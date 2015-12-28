declare @maxdocallocid int;
select @maxdocallocid = isnull(max(allocationid),0) from dbo.doc_allocation;

-- populate data to doc_allocation from tempdocalloc
insert into dbo.doc_allocation(
	allocationid,
	allocationtype,
	allocatedfromid,
	allocatedfromentryno,
	allocatedtoid,
	allocatedtoentryno,
	allocationentryno,
	allocationdate,
	allocateddebit,
	allocatedcredit,
	allowmodify)
	select 
	allocid+@maxdocallocid,
	allocationtype,
	allocatedfromid,
	allocatedfromentryno,
	allocatedtoid,
	allocatedtoentryno,
	allocationentryno,
	allocationdate,
	allocateddebit,
	allocatedcredit,
	allowmodify
	from tempdocalloc order by allocid;
	
--populate data to doc_allocation_balance from tempdocalloc
insert into dbo.doc_allocation_balance(
	allocatedid,
	allocatedentryno,
	allocationtype,
	allocateddebit,
	allocatedcredit)
	select
		allocatedfromid,
		allocatedfromentryno,
		allocationtype,
		allocateddebit,
		allocatedcredit
	from tempdocalloc;


declare @maxtranallocid int
select @maxtranallocid = isnull(max(allocationid),0) from dbo.tran_allocation;

--populate data to tran_allocation balance from tempdocalloc	
insert into dbo.tran_allocation(
	allocationid,
	allocationtype,
	allocatedfromid,
	allocatedfromentryno,
	allocatedtoid,
	allocatedtoentryno,
	allocationentryno,
	allocationdate,
	allocateddebit,
	allocatedcredit,
	allowmodify)
	select 
	allocid+@maxtranallocid,
	allocationtype,
	allocatedfromid,
	allocatedfromentryno,
	allocatedtoid,
	allocatedtoentryno,
	allocationentryno,
	allocationdate,
	allocateddebit,
	allocatedcredit,
	allowmodify
	from temptranalloc order by allocid;

--populate data to tran_allocation_balance from tempdocalloc	
insert into dbo.tran_allocation_balance(
	allocatedid,
	allocatedentryno,
	allocationtype,
	allocateddebit,
	allocatedcredit)
	select
		allocatedfromid,
		allocatedfromentryno,
		allocationtype,
		allocateddebit,
		allocatedcredit
	from temptrancalloc;
