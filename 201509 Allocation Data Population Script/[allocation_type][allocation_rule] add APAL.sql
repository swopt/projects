BEGIN TRAN
DECLARE @id INT
DECLARE @allocationtype CHAR(4)
DECLARE @trantypefrom CHAR(4)
DECLARE @trantypeto CHAR(4)

SET @allocationtype = 'APAL'
IF (SELECT COUNT(0) FROM allocation_type WHERE allocation_type = @allocationtype) = 0
BEGIN
INSERT INTO allocation_type (allocation_type_id,ledger_type,allocation_type,allocation_desc,ledger_type_to,allocation_value_type,allocation_method)
SELECT ISNULL(MAX(allocation_type_id),0) + 1,
'AP',
@allocationtype,
'AP Allocation Type',
'AP',
'',
NULL
FROM allocation_type
END

SET @id = (SELECT allocation_type_id FROM allocation_type WHERE allocation_type = @allocationtype)

--**********************************************
--			AP Debit Note (To Creditor)         
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'DC' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'DC' --AP Debit Note (To Creditor)
SET @trantypeto = 'DC' --AP Debit Note (To Creditor)
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'DC' --AP Debit Note (To Creditor)
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DC' --AP Debit Note (To Creditor)
SET @trantypeto = 'DP' --AP Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DC' --AP Debit Note (To Creditor)
SET @trantypeto = 'JB' --AP Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DC' --AP Debit Note (To Creditor)
SET @trantypeto = 'CC' --AP Credit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DC' --AP Debit Note (To Creditor)
SET @trantypeto = 'UI' --Vendor Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DC' --AP Debit Note (To Creditor)
SET @trantypeto = 'JP' --AP Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DC' --AP Debit Note (To Creditor)
SET @trantypeto = 'RP' --AP Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AP Payment Voucher         
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'PP' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'PP' --AP Payment Voucher
SET @trantypeto = 'PP' --AP Payment Voucher
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'PP' --AP Payment Voucher
SET @trantypeto = 'DP' --AP Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PP' --AP Payment Voucher
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PP' --AP Payment Voucher
SET @trantypeto = 'RP' --AP Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PP' --AP Payment Voucher
SET @trantypeto = 'JP' --AP Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PP' --AP Payment Voucher
SET @trantypeto = 'JB' --AP Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PP' --AP Payment Voucher
SET @trantypeto = 'UI' --Vendor Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PP' --AP Payment Voucher
SET @trantypeto = 'CC' --AP Credit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'PP' --AP Payment Voucher
SET @trantypeto = 'FP' --Purchase Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AP Credit Note (From Creditor)        
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'CP' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'CP' --AP Credit Note (From Creditor)
SET @trantypeto = 'CP' --AP Credit Note (From Creditor)
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'CP' --AP Credit Note (From Creditor)
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'CP' --AP Credit Note (From Creditor)
SET @trantypeto = 'DP' --AP Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'CP' --AP Credit Note (From Creditor)
SET @trantypeto = 'JB' --AP Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AP Contra Voucher
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'JX' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'JX' --AP Contra Voucher
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'DP' --AP Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'CC' --AP Credit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'JP' --AP Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'RP' --AP Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'JB' --AP Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'UI' --Vendor Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'CP' --AP Credit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'DC' --AP Debit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'PP' --AP Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JX' --AP Contra Voucher
SET @trantypeto = 'JP' --AP Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AP Journal Voucher
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'JP' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'JP' --AP Journal Voucher
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'DP' --AP Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'CC' --AP Credit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'RP' --AP Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'JB' --AP Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'UI' --Vendor Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'CP' --AP Credit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'DC' --AP Debit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JP' --AP Journal Voucher
SET @trantypeto = 'PP' --AP Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AP Debit Note (From Creditor)
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'DP' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'DP' --AP Debit Note (From Creditor)
SET @trantypeto = 'DP' --AP Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'DP' --AP Debit Note (From Creditor)
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DP' --AP Debit Note (From Creditor)
SET @trantypeto = 'JB' --AP Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'DP' --AP Debit Note (From Creditor)
SET @trantypeto = 'CC' --AP Credit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AP Receipt
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'RP' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'RP' --AP Receipt
SET @trantypeto = 'RP' --AP Receipt
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'RP' --AP Receipt
SET @trantypeto = 'JB' --AP Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RP' --AP Receipt
SET @trantypeto = 'PP' --AP Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RP' --AP Receipt
SET @trantypeto = 'CP' --AP Credit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RP' --AP Receipt
SET @trantypeto = 'JP' --AP Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'RP' --AP Receipt
SET @trantypeto = 'DC' --AP Debit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AP Opening Balance Voucher
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'JB' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'JB' --AP Opening Balance Voucher
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'DP' --AP Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'CC' --AP Credit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'JP' --AP Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'RP' --AP Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'UI' --Vendor Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'CP' --AP Credit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'DC' --AP Debit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JB' --AP Opening Balance Voucher
SET @trantypeto = 'PP' --AP Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			AP Journal Voucher (For PV Reversal)
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'JA' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'JA' --AP Journal Voucher (For PV Reversal)
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'CP' --AP Credit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'DC' --AP Debit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'PP' --AP Payment Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'JP' --AP Journal Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'DP' --AP Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'CC' --AP Credit Note (To Creditor)
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'RP' --AP Receipt
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'JA' --AP Journal Voucher (For PV Reversal)
SET @trantypeto = 'JB' --AP Opening Balance Voucher
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			Purchase Debit Note
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'TP' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'TP' --Purchase Debit Note
SET @trantypeto = 'TP' --Purchase Debit Note
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'TP' --Purchase Debit Note
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'TP' --Purchase Debit Note
SET @trantypeto = 'UI' --Vendor Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			Purchase Debit Note (From Creditor)
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'FP' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'FP' --Purchase Debit Note (From Creditor)
SET @trantypeto = 'FP' --Purchase Debit Note (From Creditor)
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'FP' --Purchase Debit Note (From Creditor)
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'FP' --Purchase Debit Note (From Creditor)
SET @trantypeto = 'UI' --Vendor Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			Purchase Credit Note
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'KP' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'KP' --Purchase Credit Note
SET @trantypeto = 'KP' --Purchase Credit Note
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'KP' --Purchase Credit Note
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'KP' --Purchase Credit Note
SET @trantypeto = 'UI' --Vendor Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END
END

--**********************************************
--			Purchase Credit Note (From Creditor)
--**********************************************
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = 'GP' AND subs_code = 'AP') = 1
BEGIN
SET @trantypefrom = 'GP' --Purchase Credit Note (From Creditor)
SET @trantypeto = 'GP' --Purchase Credit Note (From Creditor)
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END

SET @trantypefrom = 'GP' --Purchase Credit Note (From Creditor)
SET @trantypeto = 'IP' --AP Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
@trantypeto,
'R'
FROM allocation_rule
END
END

SET @trantypefrom = 'GP' --Purchase Credit Note (From Creditor)
SET @trantypeto = 'UI' --Vendor Invoice
IF (SELECT COUNT(0) FROM doc_type_profile WHERE doc_type = @trantypeto AND subs_code = 'AP') = 1
BEGIN
IF (SELECT COUNT(0) FROM allocation_rule WHERE allocation_type_id = @id AND tran_type_from = @trantypefrom AND tran_type_to = @trantypeto) = 0
BEGIN
INSERT INTO allocation_rule (allocation_rule_id,allocation_type_id,tran_type_from,ledger_type_to,tran_type_to,allocation_nature)
SELECT ISNULL(MAX(allocation_rule_id),0) + 1,
@id,
@trantypefrom,
'AP',
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
