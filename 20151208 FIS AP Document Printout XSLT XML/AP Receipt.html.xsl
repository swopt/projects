<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<!-- TODO: Auto-generated template -->
		<html>
			<head>
				<style>
					table {width:100%;border-collapse:collapse}
					th {border:1px solid black}
					td {margin:2px}
					td.repoptions {colspan:100%;border-bottom:1px solid black}
					td.datacell {border:1px solid black;border-style:none solid none solid}
					.bolditalic {font-weight:bold;font-style:italic}
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
				<tr><td><br/></td></tr>
				<tr><th>PAYMENT MODE</th><th>REFERENCE NO.</th><th>DATE</th><th colspan="2">AMOUNT</th></tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="Details/Detail[@type='data']"/>
				<xsl:apply-templates select="Details/Detail[@type='total']"/>
			</tbody>
		</table>
		<div style="float:right">
			<div style="height:100px;width:200px;border-bottom:1px solid black"/>
			<div style="width:200px;display:table-cell;text-align:center">Authorised Signature</div>
		</div>
	</xsl:template>
	<xsl:template match="Header">
		<tr><td colspan="100%">
			<div>
				<span style="font-weight:bold;font-size:larger"><xsl:value-of select="OrgnDetails/OrgnName"/></span><br/>
				<span style="font-size:10pt"><xsl:value-of select="OrgnDetails/OrgnRegNo"/></span>
			</div>
			<div>
				<div style="float:left;font-size:10pt">
					<div>
						<xsl:value-of select="OrgnDetails/Address1"/><br/>
						<xsl:value-of select="OrgnDetails/Address2"/><br/>
						<xsl:value-of select="OrgnDetails/Address3"/>
					</div>
					<div>
						<table>
							<tbody>
								<tr><td>Tel</td><td>: <xsl:value-of select="OrgnDetails/ContactNo1"/>/<xsl:value-of select="OrgnDetails/ContactNo2"/></td></tr>
								<tr><td>Fax</td><td>: <xsl:value-of select="OrgnDetails/FaxNo1"/></td></tr>
							</tbody>
						</table>
					</div>
				</div>
				<div style="float:right">
					<div style="float:right;font-weight:bold">OFFICIAL RECEIPT</div>
					<table>
						<tr><td style="font-weight:bold">No.</td><td style="font-weight:bold">:</td><td><xsl:value-of select="ReportOptions/DocRefNo"/></td></tr>
						<tr><td style="font-weight:bold">Date</td><td style="font-weight:bold">:</td><td><xsl:value-of select="ReportOptions/DocDate"/></td></tr>
					</table>
				</div>
			</div>
		</td></tr>
	</xsl:template>
	<xsl:template match="ReportOptions">
		<tr>
			<td colspan="100%">
				<table>
					<tr><td class="bolditalic">Received From</td><td class="repoptions"><xsl:value-of select="AccountName"/></td></tr>
					<tr><td class="bolditalic">The Sum of <xsl:value-of select="CurrencyCode"/></td><td class="repoptions"><xsl:value-of select="AmountDescription"/>&#160;only</td></tr>
					<tr><td class="bolditalic">Being Payment of</td><td class="repoptions"><xsl:value-of select="PaymentDescription"/></td></tr>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="Detail">
		<tr>
			<td class="datacell"><xsl:value-of select="PaymentMode"/></td>
			<td class="datacell"><xsl:value-of select="RefNo"/></td>
			<td class="datacell" align="right"><xsl:value-of select="Date"/></td>
			<td class="datacell" colspan="2" align="right"><xsl:value-of select="Amount"/></td>
		</tr>
	</xsl:template>
	<xsl:template match="Detail[@type='total']">
		<tr style="border-bottom:1px solid black">
			<td class="datacell"/>
			<td class="datacell"/>
			<td class="datacell"/>
			<td style="font-weight:bold">Total :</td>
			<td align="right" 
				style="border:1px solid black;border-style:solid solid none none;font-weight:bold">
				<xsl:value-of select="Amount"/></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>

