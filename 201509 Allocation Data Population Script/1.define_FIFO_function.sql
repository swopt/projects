--example of function call  select * from GetBatchAmounts(58);
/* --Run if statement below to delete function
if exists(
	SELECT * FROM sysobjects WHERE id = object_id(N'GetBatchAmounts') 
		AND xtype IN (N'FN', N'IF', N'TF')
) drop function GetBatchAmounts
*/
CREATE FUNCTION [dbo].[GetBatchAmounts]
(
	@requestedAmount int,
	@docid int,
	@maxentry int,
	@mode varchar(10)
)
RETURNS 
@tBatchResults TABLE 
(   
	row int identity(1,1),
	Batch nvarchar(50),
	--Amount int
	Amt decimal(18,4)
)
AS
BEGIN
	/*This is just a mock of rersults of your query*/
	DECLARE @RS_GIN_Master TABLE( 

	 --Qty int,
	 Qty decimal(18,4),
	 batch_no NVARCHAR(4000),
	 accept_date DATETIME
	)
	
	DECLARE @entryno char(15);
	select @entryno = min(entry_no_a0) from doc_detail where doc_id = @docid and entry_no_a0>@maxentry
	DECLARE @entryamt decimal(18,4)
	while @entryno is not null
	begin
		IF (@mode='DEBIT') 
			BEGIN
			insert into @RS_GIN_Master(Qty,batch_no,accept_date)
			select entry_debit,entry_no_a0 ,CAST(CAST(2015 AS varchar) + '-' + CAST(8 AS varchar) + '-' + CAST(4 AS varchar) AS DATETIME)
			from doc_detail where entry_debit>0 and entry_credit=0 and doc_id=@docid and entry_no_a0=@entryno
			select @entryno = min(entry_no_a0) from doc_detail where entry_debit>0 and entry_credit=0 and doc_id=@docid and entry_no_a0>@entryno
			END
		ELSE IF (@mode='CREDIT') 
			BEGIN
			insert into @RS_GIN_Master(Qty,batch_no,accept_date)
			select entry_credit,entry_no_a0 ,CAST(CAST(2015 AS varchar) + '-' + CAST(8 AS varchar) + '-' + CAST(4 AS varchar) AS DATETIME)
			from doc_detail where entry_credit>0 and entry_debit=0 and doc_id=@docid and entry_no_a0=@entryno
			select @entryno = min(entry_no_a0) from doc_detail where entry_credit>0 and entry_debit=0 and doc_id=@docid and entry_no_a0>@entryno
			END
		
	end
	
	 DECLARE @Qty decimal(18,4)
	 DECLARE @batch_no NVARCHAR(4000)
	 DECLARE @accept_date DATETIME

	DECLARE myCursor CURSOR FOR

	SELECT Qty, batch_no, accept_date FROM @RS_GIN_Master ORDER BY accept_date ASC
	
	OPEN myCursor

	FETCH NEXT FROM myCursor INTO  @Qty, @batch_no,@accept_date

	WHILE (@@FETCH_STATUS = 0 AND @requestedAmount > 0 ) 
	BEGIN
		Declare @actualQty decimal(18,4)
		IF @requestedAmount > @Qty 
			SET @actualQty = @Qty
			
		ELSE	
			SET @actualQty = @requestedAmount
		
		-- we've found a row. Name look for the matching row in prize
		INSERT INTO @tBatchResults (batch, Amt)
		SELECT @batch_no, @actualQty
		
		set @requestedAmount  = @requestedAmount - @actualQty

		FETCH NEXT FROM myCursor INTO @Qty, @batch_no,@accept_date

	END /*WHILE*/

	CLOSE myCursor
	DEALLOCATE myCursor

	RETURN
END


