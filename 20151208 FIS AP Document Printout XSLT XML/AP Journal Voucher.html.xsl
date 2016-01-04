<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
<!--<xsl:output method="xml" indent="yes"/>-->

<xsl:template match="/">
      <html>
        <head>
          <style>
          	body {font-family:fantasy}
            table {border-collapse:collapse;width:100%}
            th {border:1px solid black;border-style:solid none solid none;text-align:left}
            .bold {font-weight:bold}
            .alignTop {vertical-align:top}
            .smallText {font-size:smaller}
          </style>
        </head>
        <body>
          <xsl:apply-templates select="//Document"/>
        </body>
      </html>
    </xsl:template>
  <xsl:template match="Document">
    <table width="100%">
      <thead>
        <xsl:apply-templates select="Header"/>
        <xsl:apply-templates select="Header/ReportOptions"/>
        <tr><td><br/></td></tr>
        <tr style="border:solid solid none none" class="smallText">
	      <th style="padding-right:5px">No.</th>
	      <th style="width:70%">Particulars</th>
	      <th style="width:15%;text-align:right">Debit (<xsl:value-of select="Header/ReportOptions/CurrencyCode"/>)</th>
	      <th style="width:15%;text-align:right">Credit (<xsl:value-of select="Header/ReportOptions/CurrencyCode"/>)</th>
	    </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="Details/Detail[@type='data']"/>
        <xsl:apply-templates select="Details/Detail[@type='total']"/>
      </tbody>
    </table>
   </xsl:template>
  <xsl:template match="Header">
      <tr><td colspan="100%" align="center" class="bold"><xsl:value-of select="OrgnDetails/OrgnName"/></td></tr>
      <tr><td colspan="100%" align="center" class="smallText">(<xsl:value-of select="OrgnDetails/OrgnRegNo"/>)</td></tr>
      <tr><td colspan="100%" align="center" class="smallText"><xsl:value-of select="OrgnDetails/Address1"/>,</td></tr>
      <tr><td colspan="100%" align="center" class="smallText"><xsl:value-of select="OrgnDetails/Address2"/>,</td></tr>
      <tr><td colspan="100%" align="center" class="smallText"><xsl:value-of select="OrgnDetails/Address3"/></td></tr>
      <tr><td colspan="100%" align="center" class="smallText">Tel:<xsl:value-of select="OrgnDetails/ContactNo1"/>&#160;Fax:<xsl:value-of select="OrgnDetails/ContactNo2"/></td></tr>
      <tr><td colspan="100%" align="center" class="bold">Accounts Payable</td></tr>
      <tr><td colspan="100%" align="center" class="bold" style="font-size:18pt">Journal Voucher</td></tr>
  </xsl:template>
  <xsl:template match="ReportOptions">
    <tr>
      <td colspan="100%" class="smallText">
        <table>
          <tbody>
            <tr class="alignTop">
              <td class="bold">Account No.</td><td>:</td><td><xsl:value-of select="AccountNo"/></td>
              <td class="bold">Voucher No.</td><td>:</td><td><xsl:value-of select="VoucherNo"/></td>
            </tr>
            <tr class="alignTop">
              <td class="bold">Account Name</td><td>:</td><td><xsl:value-of select="AccountName"/></td>
              <td class="bold">Voucher Date</td><td>:</td><td><xsl:value-of select="VoucherDate"/></td>
            </tr>
            <tr class="alignTop">
              <td class="bold">Description</td><td>:</td><td><xsl:value-of select="DocDescription"/></td>
              <td class="bold">Reference No.</td><td>:</td><td><xsl:value-of select="ReferenceNo"/></td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="Detail">
    <tr class="smallText">
      <td align="right" style="padding-right:5px"><xsl:if test="@type!='total'"><xsl:value-of select="position()"/></xsl:if></td>
      <td><xsl:value-of select="Particulars"/></td>
      <td align="right"><xsl:value-of select="AmountDebit"/></td>
      <td align="right"><xsl:value-of select="AmountCredit"/></td>
    </tr>
  </xsl:template>
  <xsl:template match="Detail[@type='total']">
    <tr class="smallText">
     <td class="bold" colspan="2" align="right">Total</td>
     <td class="bold" align="right"><xsl:value-of select="AmountDebit"/></td>
     <td class="bold" align="right"><xsl:value-of select="AmountCredit"/></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>


