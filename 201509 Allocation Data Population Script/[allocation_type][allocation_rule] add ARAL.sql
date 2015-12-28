BEGIN TRAN
DECLARE @id INT
DECLARE @allocationtype CHAR(4)
DECLARE @trantypefrom CHAR(4)
DECLARE @trantypeto CHAR(4)

SET @allocationtype = 'ARAL'
IF (SELECT COUNT(0) FROM allocation_type WHERE allocation_type = @allocationtype) = 0
BEGIN
INSERT INTO allocation_type (allocation_type_id,ledger_type,allocation_type,allocation_desc,ledger_type_to,allocation_value_type,allocation_method)
SELECT ISNULL(MAX(allocation_type_id),0) + 1,
'AR',
@allocationtype,
'AR Allocation Type',
'AR',
'',
NULL
FROM allocation_type
END

SET @id = (SELECT allocation_type_id FROM allocation_type WHERE allocation_type = @allocationtype)

--**********************************************
--			AR Credit Note (To Debtor)
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'CR' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'CR' --AR Credit Note (To Debtor)
SET @trantypeto = 'CR' --AR Credit Note (To Debtor)
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'CR' --AR Credit Note (To Debtor)
SET @trantypeto = 'IR' --AR Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'CR' --AR Credit Note (To Debtor)
SET @trantypeto = 'DR' --AR Debit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'CR' --AR Credit Note (To Debtor)
SET @trantypeto = 'JO' --AR Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'CR' --AR Credit Note (To Debtor)
SET @trantypeto = 'SI' --Sales Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AR Contra Voucher
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'JW' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'JW' --AR Contra Voucher
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'CR' --AR Credit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'DD' --AR Debit Note (From Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'RR' --AR Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'JR' --AR Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'JD' --AR Doubtful Debt Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'JO' --AR Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'IR' --AR Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'DR' --AR Debit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'CD' --AR Credit Note (From Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JW' --AR Contra Voucher
SET @trantypeto = 'PR' --AR Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AR Opening Balance Voucher
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'JO' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'JO' --AR Opening Balance Voucher
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'PR' --AR Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'CR' --AR Credit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'DD' --AR Credit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'RR' --AR Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'JR' --AR Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'JD' --AR Doubtful Debt Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'IR' --AR Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'DR' --AR Debit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'CD' --AR Credit Note (From Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'IB' --AR Vessel Bill
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'IS' --AR RS Bill
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'ID' --AR RD Bill
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'II' --AR Intergrated Import Document
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'I2' --Harwood Type D and Seized Log Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'IE' --AR RD Supplementary Bill
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'IT' --AR RS Supplementary Bill
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'IC' --AR Vessel Supplementary Bill
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'IA' --AR Surcharge Bill
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JO' --AR Opening Balance Voucher
SET @trantypeto = 'SI' --Sales Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AR Payment Voucher
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'PR' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'PR' --AR Payment Voucher
SET @trantypeto = 'PR' --AR Payment Voucher
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'PR' --AR Payment Voucher
SET @trantypeto = 'JO' --AR Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PR' --AR Payment Voucher
SET @trantypeto = 'RR' --AR Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PR' --AR Payment Voucher
SET @trantypeto = 'CR' --AR Credit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PR' --AR Payment Voucher
SET @trantypeto = 'JR' --AR Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AR Receipt
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'RR' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'RR' --AR Receipt
SET @trantypeto = 'RR' --AR Receipt
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'RR' --AR Receipt
SET @trantypeto = 'IR' --AR Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RR' --AR Receipt
SET @trantypeto = 'DR' --AR Debit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RR' --AR Receipt
SET @trantypeto = 'JO' --AR Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RR' --AR Receipt
SET @trantypeto = 'PR' --AR Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RR' --AR Receipt
SET @trantypeto = 'JR' --AR Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RR' --AR Receipt
SET @trantypeto = 'SI' --Sales Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RR' --AR Receipt
SET @trantypeto = 'TS' --Sales Debit Note
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AR Debit Note (From Debtor)
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'DD' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'DD' --AR Debit Note (From Debtor)
SET @trantypeto = 'DD' --AR Debit Note (From Debtor)
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'DD' --AR Debit Note (From Debtor)
SET @trantypeto = 'IR' --AR Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DD' --AR Debit Note (From Debtor)
SET @trantypeto = 'DR' --AR Debit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DD' --AR Debit Note (From Debtor)
SET @trantypeto = 'CD' --AR Credit Note (From Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DD' --AR Debit Note (From Debtor)
SET @trantypeto = 'JO' --AR Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DD' --AR Debit Note (From Debtor)
SET @trantypeto = 'SI' --Sales Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AR Journal Voucher
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'JR' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'JR' --AR Journal Voucher
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'SI' --Sales Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'CR' --AR Credit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'DD' --AR Debit Note (From Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'RR' --AR Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'JD' --AR Doubtful Debt Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'JO' --AR Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'IR' --AR Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'DR' --AR Debit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'CD' --AR Credit Note (From Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JR' --AR Journal Voucher
SET @trantypeto = 'PR' --AR Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AR Journal Voucher (RC Reversal)
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'J1' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'J1' --AR Journal Voucher (RC Reversal)
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'PR' --AR Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'IR' --AR Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'DR' --AR Debit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'CD' --AR Credit Note (From Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'JR' --AR Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'JO' --AR Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'CR' --AR Credit Note (To Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'DD' --AR Debit Note (From Debtor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'RR' --AR Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'J1' --AR Journal Voucher (RC Reversal)
SET @trantypeto = 'JD' --AR Doubtful Debt Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			Sales Debit Note
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'TS' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'TS' --Sales Debit Note
SET @trantypeto = 'TS' --Sales Debit Note
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'TS' --Sales Debit Note
SET @trantypeto = 'IR' --AR Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'TS' --Sales Debit Note
SET @trantypeto = 'SI' --Sales Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			Sales Credit Note
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'KS' AND subs_code = 'AR') = 1
BEGIN
SET @trantypefrom = 'KS' --Sales Credit Note
SET @trantypeto = 'KS' --Sales Credit Note
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'KS' --Sales Credit Note
SET @trantypeto = 'IR' --AR Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'KS' --Sales Credit Note
SET @trantypeto = 'SI' --Sales Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AR') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AR',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--select * from allocation_type where allocation_type_id = @id
--select * from allocation_rule where allocation_type_id = @id order by allocation_rule_id
--ROLLBACK TRAN
COMMIT TRAN
