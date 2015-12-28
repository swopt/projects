if (OBJECT_ID('tempdocalloc','U') is not null) drop table tempdocalloc;
if (OBJECT_ID('temptranalloc','U') is not null) drop table temptranalloc;
if exists(
	SELECT * FROM sysobjects WHERE id = object_id(N'GetBatchAmounts') 
		AND xtype IN (N'FN', N'IF', N'TF')
) drop function GetBatchAmounts