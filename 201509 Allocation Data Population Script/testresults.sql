select count(*),allocationtype from tempdocalloc group by allocationtype

select * from doc_allocation_balance

select * from tran_allocation_balance

select max(allocatedfromid) from doc_allocation
select top 100 * from doc_detail
select max(tran_id) from tran_detail
select max(allocatedfromid),max(allocatedtoid) from tran_allocation

select * from tempdocalloc

select * from allocation_type_rules_v

select count(*) from temptranalloc where allocatedfromid>840000

select * from temptranalloc

select top 10 * from doc_allocation_balance
select top 10 * from tran_allocation_balance

select top 10 * from doc_dist_entry_v

select td.* from tran_detail_ext td
join doc_dist_entry dde
on td.tran_id=dde.tran_id
join doc_detail dd
on dde.doc_id=dd.doc_id and dde.doc_entry_no=dd.entry_no_a0
where dd.doc_id = 294704

select distinct dde.tran_id from doc_dist_entry_v dde 
		join allocation_type_rules_v atr
		on dde.subs_code = atr.ledger_type_to
		where dde.doc_id2=294704 and dde.doc_entry_no=1 and atr.allocation_type='APAL' and dde.dist_post_status = 'POSTED'
