<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<style>
					body {font-family:monospace}
					table {width:100%;border-collapse:collapse}
					th {border:1px solid black;border-style:solid none solid none;text-align:left}
					td {margin:2px}
					td.repoptions {colspan:100%;border-bottom:1px solid black}
					td.datacell {border:1px solid black;border-style:none solid none solid}
					.bolditalic {font-weight:bold;font-style:italic}
					.bold {font-weight:bold}
				</style>
			</head>
			<body>
				<xsl:apply-templates select="//Document"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="Document">
		<table>
			<thead>
				<xsl:apply-templates select="Header"/>
				<xsl:apply-templates select="Header/ReportOptions"/>
			</thead>
			<tbody>
				<tr><td><div style="height:5px"/></td></tr>
				<tr><td colspan="100%">
					<table>
						<tr><th>Bank Account</th><th>Payment Type</th><th>Cheque/Ref No.</th><th>Transact Date</th><th>Amount (<xsl:value-of select="//CurrencyCode"/>)</th></tr>
						<xsl:apply-templates select="Details/Detail[@type='bank']"/>
						<xsl:apply-templates select="Details/Detail[@type='bankTotal']"/>
					</table>
				</td></tr>
				<tr><td><div style="padding-top:5px"/></td></tr>
				<tr><td colspan="100%" style="border:1px solid black">
					<div class="bold">Pay for</div>
					<table>
						<tr><th>Doc. Reference</th><th>Date</th><th>Particular</th><th>Amount (<xsl:value-of select="//CurrencyCode"/>)</th></tr>
						<xsl:apply-templates select="Details/Detail[@type='payFor']"/>
						<xsl:apply-templates select="Details/Detail[@type='payForTotal']"/>
					</table>
				</td></tr>
				<tr><td><div class="bold" style="padding-top:5px">GL Posting</div></td></tr>
				<tr><td colspan="100%">
					<table>
						<tr><th>Account No.</th><th>Account Name</th><th>Debit</th><th>Credit</th></tr>
						<xsl:apply-templates select="Details/Detail[@type='glPosting']"/>
						<xsl:apply-templates select="Details/Detail[@type='glPostingTotal']"/>
					</table>
				</td></tr>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="Header">
	  <tr><td colspan="100%" align="center" class="bold"><xsl:value-of select="OrgnDetails/OrgnName"/></td></tr>
      <tr><td colspan="100%" align="center">(<xsl:value-of select="OrgnDetails/OrgnRegNo"/>)</td></tr>
      <tr><td colspan="100%" align="center"><xsl:value-of select="OrgnDetails/Address1"/>,</td></tr>
      <tr><td colspan="100%" align="center"><xsl:value-of select="OrgnDetails/Address2"/>,</td></tr>
      <tr><td colspan="100%" align="center"><xsl:value-of select="OrgnDetails/Address3"/></td></tr>
      <tr><td colspan="100%" align="center">Tel:<xsl:value-of select="OrgnDetails/ContactNo1"/>&#160;Fax:<xsl:value-of select="OrgnDetails/ContactNo2"/></td></tr>
      <tr><td><br/></td></tr>
      <tr><td colspan="100%" align="center" class="bold">PAYMENT VOUCHER</td></tr>
	</xsl:template>
	<xsl:template match="ReportOptions">
      <tr><td colspan="100%">
      	<div style="float:right">
      		<table>
      			<tr><td class="bold">PV No.</td><td class="bold">:</td><td><xsl:value-of select="DocRefNo"/></td></tr>
      			<tr><td class="bold">Date</td><td class="bold">:</td><td><xsl:value-of select="DocDate"/></td></tr>
      		</table>
      	</div>
      </td></tr>
      <tr><td colspan="100%">
      	<table>
      		<tr><td class="bold">Pay to</td><td class="bold">:</td><td style="border-bottom:1px solid black"><xsl:value-of select="PaymentTo"/></td></tr>
      		<tr><td class="bold"><xsl:value-of select="CurrencyCode"/></td><td class="bold">:</td><td style="border-bottom:1px solid black"><xsl:value-of select="AmountDescription"/>&#160;only</td></tr>
      		<tr><td class="bold">Account</td><td class="bold">:</td><td style="border-bottom:1px solid black"><xsl:value-of select="AccountName"/></td></tr>
      	</table>
      </td></tr>
      <tr><td colspan="100%" class="bold" style="padding-top:5px;padding-bottom:5px"><div style="border:1px solid black;border-style:solid none solid none" >Description of Payment</div></td></tr>
	  <tr><td colspan="100%"><xsl:value-of select="PaymentDescription"/></td></tr>
	</xsl:template>
	<xsl:template match="Detail[@type='bank']">
		<tr>
			<td><xsl:value-of select="BankAccount"/></td>
			<td><xsl:value-of select="PaymentMode"/></td>
			<td><xsl:value-of select="PaymentRefNo"/></td>
			<td><xsl:value-of select="TransactionDate"/></td>
			<td align="right"><xsl:value-of select="format-number(Amount,'#,###.00')"/></td>
		</tr>
	</xsl:template>
	<xsl:template match="Detail[@type='bankTotal']">
		<tr>
			<td colspan="4" class="bold" align="right">TOTAL :</td>
			<td align="right"><xsl:value-of select="format-number(Amount,'#,###.00')"/></td>
		</tr>
	</xsl:template>
	<xsl:template match="Detail[@type='payFor']">
		<tr>
			<td><xsl:value-of select="DocRef"/></td>
			<td><xsl:value-of select="Date"/></td>
			<td><xsl:value-of select="PaymentDescription"/></td>
			<td align="right"><xsl:value-of select="format-number(Amount,'#,###.00')"/></td>
		</tr>
	</xsl:template>
	<xsl:template match="Detail[@type='payForTotal']">
		<tr>
			<td colspan="3" class="bold" align="right">TOTAL :</td>
			<td align="right"><xsl:value-of select="format-number(Amount,'#,###.00')"/></td>
		</tr>
	</xsl:template>
	<xsl:template match="Detail[@type='glPosting']">
		<tr>
			<td><xsl:value-of select="AccountNo"/></td>
			<td><xsl:value-of select="Accountname"/></td>
			<td align="right"><xsl:value-of select="format-number(AmountDebit,'#,###.00')"/></td>
			<td align="right"><xsl:value-of select="format-number(AmountCredit,'#,###.00')"/></td>
		</tr>
	</xsl:template>
	<xsl:template match="Detail[@type='glPostingTotal']">
		<tr>
			<td colspan="2" class="bold" align="right">TOTAL :</td>
			<td align="right"><xsl:value-of select="format-number(AmountDebit,'#,###.00')"/></td>
			<td align="right"><xsl:value-of select="format-number(AmountCredit,'#,###.00')"/></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>