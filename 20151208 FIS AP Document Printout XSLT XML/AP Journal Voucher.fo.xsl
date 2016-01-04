<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:param name="logoImg"/>
<xsl:key name="by-row" match="Detail" use="@Row"/>

<xsl:attribute-set name="tablecell-style">
	<xsl:attribute name="border">solid</xsl:attribute>
	<xsl:attribute name="border-width">0.1mm</xsl:attribute>
	<xsl:attribute name="text-align">right</xsl:attribute>
	<xsl:attribute name="padding-top">1mm</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="header-xlarge-center" use-attribute-sets="header-xlarge">
	<xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>		
<xsl:attribute-set name="header-large-center" use-attribute-sets="header-large">
	<xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="header-xlarge" use-attribute-sets="header">
	<xsl:attribute name="font-size">16pt</xsl:attribute>
</xsl:attribute-set>		
<xsl:attribute-set name="header-large" use-attribute-sets="header">
	<xsl:attribute name="font-size">14pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="header-center" use-attribute-sets="header">
	<xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="header">
	<xsl:attribute name="font-family">Times New Roman</xsl:attribute>
	<xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="text">
	<xsl:attribute name="font-family">Times New Roman</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="text-center" use-attribute-sets="text">
	<xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>	
<xsl:attribute-set name="text-xsmall" use-attribute-sets="text">
	<xsl:attribute name="font-size">11pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="text-xsmall-center" use-attribute-sets="text-xsmall">
	<xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="text-xsmall-bold" use-attribute-sets="text-xsmall">
	<xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="text-xxsmall" use-attribute-sets="text">
	<xsl:attribute name="font-size">8pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="td_align_right">
	<xsl:attribute name="border-top-style">solid</xsl:attribute>
	<xsl:attribute name="border-bottom-style">solid</xsl:attribute>
	<xsl:attribute name="border-left-style">solid</xsl:attribute>
	<xsl:attribute name="border-right-style">solid</xsl:attribute>
	<xsl:attribute name="text-align">right</xsl:attribute>
</xsl:attribute-set>
 
<xsl:template match="Documents/Document">
	
	<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

		<xsl:element name="fo:layout-master-set">
		
			<xsl:element name="fo:simple-page-master">
				<xsl:attribute name="master-name">A4</xsl:attribute>
				<xsl:attribute name="page-width">21cm</xsl:attribute>
				<xsl:attribute name="page-height">29.7cm</xsl:attribute>
				<xsl:attribute name="margin-top">1cm</xsl:attribute>
				<xsl:attribute name="margin-left">1cm</xsl:attribute>
				<xsl:attribute name="margin-right">1cm</xsl:attribute>
				<xsl:attribute name="margin-bottom">1cm</xsl:attribute>
					
					
					<xsl:element name="fo:region-body">
						<xsl:attribute name="margin-top">7.5cm</xsl:attribute>
						<xsl:attribute name="margin-bottom">4cm</xsl:attribute>
					</xsl:element>
					<xsl:element name="fo:region-before">
						<xsl:attribute name="extent">11.3cm</xsl:attribute>
					</xsl:element>
					<xsl:element name="fo:region-after">
						<xsl:attribute name="extent">4cm</xsl:attribute>
					</xsl:element>
					<xsl:element name="fo:region-start">
						<xsl:attribute name="extent">0cm</xsl:attribute>
					</xsl:element>
					<xsl:element name="fo:region-end">
						<xsl:attribute name="extent">0cm</xsl:attribute>
					</xsl:element>

			</xsl:element>
		
		</xsl:element>
		<xsl:element name="fo:page-sequence">
			<xsl:attribute name="master-reference">A4</xsl:attribute>
			
			 <xsl:element name="fo:static-content">
				<xsl:attribute name="flow-name">xsl-region-before</xsl:attribute>
				<fo:block-container height="7cm">
					<xsl:apply-templates select="Header"/> 
				</fo:block-container>
				<xsl:call-template name="tableHeader"/>
			</xsl:element>
			
			 <xsl:element name="fo:static-content">
				<xsl:attribute name="flow-name">xsl-region-after</xsl:attribute>
					<xsl:element name="fo:block" use-attribute-sets="text-xxsmall">
						<xsl:apply-templates select="//Header/ReportOptions"/> 
						Page <xsl:element name="fo:page-number"/> of <fo:page-number-citation ref-id='total-page'/>
					</xsl:element>
				</xsl:element>
							
			<xsl:element name="fo:flow">

				
				<xsl:attribute name="flow-name">xsl-region-body</xsl:attribute>
					
					<xsl:apply-templates select="//Details"/> 
						<xsl:element name="fo:block">
							<xsl:attribute name="id">total-page</xsl:attribute>
						</xsl:element>
			</xsl:element>
			
		
		</xsl:element>
  
	</fo:root>
 
</xsl:template>

<xsl:template match="Header">

	<xsl:element name="fo:table">
  	<xsl:element name="fo:table-column"/>
	<xsl:element name="fo:table-body">
	<xsl:element name="fo:table-row">
	<xsl:element name="fo:table-cell">
		
		 <xsl:element name="fo:block" use-attribute-sets="header-large-center"><xsl:value-of select="OrgnDetails/OrgnName"/></xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-xsmall-center">(<xsl:value-of select="OrgnDetails/OrgnRegNo"/>)</xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-center"><xsl:value-of select="OrgnDetails/Address1"/></xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-center"><xsl:value-of select="OrgnDetails/Address2"/></xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-center"><xsl:value-of select="OrgnDetails/Address3"/></xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-center">Tel:<xsl:value-of select="OrgnDetails/OrgnRegNo"/>/<xsl:value-of select="OrgnDetails/ContactNo2"/>&#160;Fax:<xsl:value-of select="OrgnDetails/FaxNo1"/></xsl:element>
		<xsl:element name="fo:block"/>
		<xsl:element name="fo:block" use-attribute-sets="header-center">Accounts Payable</xsl:element>
		<xsl:element name="fo:block" use-attribute-sets="header-xlarge-center">Journal Voucher</xsl:element>
		<xsl:element name="fo:table">
			<xsl:element name="fo:table-column"><xsl:attribute name="column-width">14%</xsl:attribute></xsl:element>
			<xsl:element name="fo:table-column"><xsl:attribute name="column-width">1%</xsl:attribute></xsl:element>
			<xsl:element name="fo:table-column"><xsl:attribute name="column-width">35%</xsl:attribute></xsl:element>
			<xsl:element name="fo:table-column"><xsl:attribute name="column-width">14%</xsl:attribute></xsl:element>
			<xsl:element name="fo:table-column"><xsl:attribute name="column-width">1%</xsl:attribute></xsl:element>
			<xsl:element name="fo:table-column"><xsl:attribute name="column-width">35%</xsl:attribute></xsl:element>
	
			<xsl:element name="fo:table-body">
				<xsl:element name="fo:table-row">
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Account No.</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">:</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block"><xsl:value-of select="ReportOptions/AccountNo"/></xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Voucher No.</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">:</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block"><xsl:value-of select="ReportOptions/VoucherNo"/></xsl:element></xsl:element>
				</xsl:element>
				<xsl:element name="fo:table-row">
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Account Name</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">:</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block"><xsl:value-of select="ReportOptions/Accountname"/></xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Voucher Date</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">:</xsl:element></xsl:element>
				</xsl:element>
				<xsl:element name="fo:table-row">
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Description</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">:</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block"><xsl:value-of select="ReportOptions/DocDescription"/></xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Reference No.</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">:</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block"><xsl:value-of select="ReportOptions/ReferenceNo"/></xsl:element></xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:element>
	</xsl:element>
	</xsl:element>
	</xsl:element>
	
</xsl:template>

<xsl:template name="tableHeader">
	<fo:block font-size="10.3pt">
	<fo:table>
	<xsl:element name="fo:table-column"><xsl:attribute name="column-width">10%</xsl:attribute></xsl:element>
	<xsl:element name="fo:table-column"><xsl:attribute name="column-width">60%</xsl:attribute></xsl:element>
	<xsl:element name="fo:table-column"><xsl:attribute name="column-width">15%</xsl:attribute></xsl:element>
	<xsl:element name="fo:table-column"><xsl:attribute name="column-width">15%</xsl:attribute></xsl:element>
	
	<xsl:element name="fo:table-body">
    <xsl:element name="fo:table-row">
		<xsl:attribute name="border-top">solid</xsl:attribute>
		<xsl:attribute name="border-bottom">solid</xsl:attribute>
		<xsl:element name="fo:table-cell">
			<xsl:element name="fo:block" use-attribute-sets="text-xsmall-bold">
				No.
			</xsl:element>
		</xsl:element>
		<xsl:element name="fo:table-cell">
			<xsl:element name="fo:block" use-attribute-sets="text-xsmall-bold">
				Particulars
			</xsl:element>
		</xsl:element>
		<xsl:element name="fo:table-cell">
			<xsl:attribute name="text-align">right</xsl:attribute>
			<xsl:element name="fo:block" use-attribute-sets="text-xsmall-bold">
				Debit (MYR)
			</xsl:element>
		</xsl:element>
		<xsl:element name="fo:table-cell">
			<xsl:attribute name="text-align">right</xsl:attribute>
			<xsl:element name="fo:block" use-attribute-sets="text-xsmall-bold">
				Credit (MYR)
			</xsl:element>
		</xsl:element>
			
	</xsl:element>
	</xsl:element>
	</fo:table>
	</fo:block>
</xsl:template>

<xsl:template match="Details">
<fo:block font-size="10.3pt">
<xsl:element name="fo:table">
  	<xsl:element name="fo:table-column"><xsl:attribute name="column-width">10%</xsl:attribute></xsl:element>
	<xsl:element name="fo:table-column"><xsl:attribute name="column-width">60%</xsl:attribute></xsl:element>
	<xsl:element name="fo:table-column"><xsl:attribute name="column-width">15%</xsl:attribute></xsl:element>
	<xsl:element name="fo:table-column"><xsl:attribute name="column-width">15%</xsl:attribute></xsl:element>
	
	<xsl:element name="fo:table-body">
    	<xsl:for-each select="Detail">
    		<xsl:element name="fo:table-row">
				<xsl:element name="fo:table-cell">
					<xsl:element name="fo:block" use-attribute-sets="text-xsmall">
						<xsl:value-of select="position()"/>
					</xsl:element>
				</xsl:element>
		
				<xsl:element name="fo:table-cell">
					<xsl:element name="fo:block" use-attribute-sets="text-xsmall">
						<xsl:value-of select="Particulars"/>
					</xsl:element>
				</xsl:element>
		
				<xsl:element name="fo:table-cell">
					<xsl:attribute name="text-align">right</xsl:attribute>
					<xsl:element name="fo:block" use-attribute-sets="text-xsmall">
						<xsl:if test="AmountDebit != ''"><xsl:value-of select="format-number(AmountDebit,'#,##0.00')"/></xsl:if> 
					</xsl:element>
				</xsl:element>
		
				<xsl:element name="fo:table-cell">
					<xsl:attribute name="text-align">right</xsl:attribute>
					<xsl:element name="fo:block" use-attribute-sets="text-xsmall">
						<xsl:if test="AmountCredit != ''"><xsl:value-of select="format-number(AmountCredit,'#,##0.00')"/></xsl:if>
					</xsl:element>
				</xsl:element>
    		</xsl:element>
    	</xsl:for-each>
	
	</xsl:element>
	
	</xsl:element>

</fo:block>
</xsl:template>

<xsl:template name="formatNumber">
	<xsl:param name="val"/>
	<xsl:param name="format"/>
	<xsl:param name="printZero"/>
	<xsl:variable name="allowNegative">no</xsl:variable>
	<xsl:choose>
		<xsl:when test="number($val) &lt; 0 and $allowNegative = 'no'">
			(<xsl:value-of select="format-number(-1 * $val, $format)"/>)
		</xsl:when>
		<xsl:when test="$printZero = 'yes' and number($val)=0">
			<xsl:value-of select="format-number($val, $format)"/>
		</xsl:when>
		<xsl:when test="number($val)">
			<xsl:value-of select="format-number($val, $format)"/>
		</xsl:when>
	</xsl:choose>
</xsl:template>
</xsl:stylesheet>