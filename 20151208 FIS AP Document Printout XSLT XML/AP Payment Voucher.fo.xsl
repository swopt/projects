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
	<xsl:attribute name="font-family">Courier New</xsl:attribute>
	<xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="header-xsmall" use-attribute-sets="header">
	<xsl:attribute name="font-size">11pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="text">
	<xsl:attribute name="font-family">Courier New</xsl:attribute>
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
						<xsl:attribute name="margin-top">8.5cm</xsl:attribute>
						<xsl:attribute name="margin-bottom">3cm</xsl:attribute>
						<xsl:attribute name="extent">17cm</xsl:attribute>
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
				<fo:block-container height="9cm">
					<xsl:apply-templates select="Header"/> 
				</fo:block-container>
			</xsl:element>
			
			 <xsl:element name="fo:static-content" use-attribute-sets="text">
				<xsl:attribute name="flow-name">xsl-region-after</xsl:attribute>
					<fo:table>	
						<fo:table-column/><fo:table-column/><fo:table-column/><fo:table-column column-width="37%"/>
						<fo:table-body>
							<fo:table-row>
								<xsl:call-template name="signBox"><xsl:with-param name="msgVal">Prepared by: Mill Manager</xsl:with-param></xsl:call-template>
								<xsl:call-template name="signBox"><xsl:with-param name="msgVal">Checked by:</xsl:with-param></xsl:call-template>
								<xsl:call-template name="signBox"><xsl:with-param name="msgVal">Approved by:</xsl:with-param></xsl:call-template>
								<fo:table-cell><fo:block margin-left="5mm" margin-right="5mm" border-bottom="solid"/><fo:block text-align="center">Approved By/Date</fo:block></fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<xsl:element name="fo:block" use-attribute-sets="text-xxsmall">
						<xsl:attribute name="text-align">right</xsl:attribute>
						Page <fo:page-number/> of <fo:page-number-citation ref-id='total-page'/>
					</xsl:element>
				</xsl:element>
							
			<xsl:element name="fo:flow">

				
				<xsl:attribute name="flow-name">xsl-region-body</xsl:attribute>
				<xsl:element name="fo:table">
				  	<fo:table-column/>
					<xsl:element name="fo:table-body" use-attribute-sets="text">
						<fo:table-row><fo:table-cell><fo:block>
							<fo:table>
								<fo:table-column/><fo:table-column/><fo:table-column/><fo:table-column/><fo:table-column/>
								<fo:table-body>
									<fo:table-row font-weight="bold" border-top="solid" border-bottom="solid">
										<fo:table-cell><fo:block>Bank Account</fo:block></fo:table-cell>
										<fo:table-cell><fo:block>Payment Type</fo:block></fo:table-cell>
										<fo:table-cell><fo:block>Cheque/Ref No.</fo:block></fo:table-cell>
										<fo:table-cell><fo:block>Transact Date</fo:block></fo:table-cell>
										<fo:table-cell><fo:block>Amount (<xsl:value-of select="//CurrencyCode"/>)</fo:block></fo:table-cell>
									</fo:table-row>
									<xsl:apply-templates select="Details/Detail[@type='bank']"/>
									<xsl:apply-templates select="Details/Detail[@type='bankTotal']"/>
								</fo:table-body>
							</fo:table>
						</fo:block></fo:table-cell></fo:table-row>
						
						<fo:table-row><fo:table-cell><fo:block font-weight="bold" margin-top="5mm">Pay for</fo:block></fo:table-cell></fo:table-row>
						<fo:table-row><fo:table-cell><fo:block>
							<fo:table>
								<fo:table-column column-width="13%"/><fo:table-column column-width="14%"/>
								<fo:table-column column-width="56%"/><fo:table-column column-width="17%"/>
								<fo:table-body>
									<fo:table-row font-weight="bold" border-top="solid" border-bottom="solid">
										<fo:table-cell><fo:block>Doc. Ref.</fo:block></fo:table-cell>
										<fo:table-cell><fo:block>Date</fo:block></fo:table-cell>
										<fo:table-cell><fo:block>Particulars</fo:block></fo:table-cell>
										<fo:table-cell><fo:block>Amount (<xsl:value-of select="//CurrencyCode"/>)</fo:block></fo:table-cell>
									</fo:table-row>
									<xsl:apply-templates select="Details/Detail[@type='payFor']"/>
									<xsl:apply-templates select="Details/Detail[@type='payForTotal']"/>
								</fo:table-body>
							</fo:table>	
						</fo:block></fo:table-cell></fo:table-row>
						
						<fo:table-row><fo:table-cell><fo:block font-weight="bold" margin-top="5mm">GL Posting</fo:block></fo:table-cell></fo:table-row>
						<fo:table-row><fo:table-cell><fo:block>
							<fo:table>
								<fo:table-column column-width="20%"/><fo:table-column column-width="46%"/>
								<fo:table-column column-width="17%"/><fo:table-column column-width="17%"/>
								<fo:table-body>
									<fo:table-row font-weight="bold" border-top="solid" border-bottom="solid">
										<fo:table-cell><fo:block>Account No.</fo:block></fo:table-cell>
										<fo:table-cell><fo:block>Account Name</fo:block></fo:table-cell>
										<fo:table-cell text-align="right"><fo:block>Debit</fo:block></fo:table-cell>
										<fo:table-cell text-align="right"><fo:block>Credit</fo:block></fo:table-cell>
									</fo:table-row>
									<xsl:apply-templates select="Details/Detail[@type='glPosting']"/>
									<xsl:apply-templates select="Details/Detail[@type='glPostingTotal']"/>
								</fo:table-body>
							</fo:table>	
						</fo:block></fo:table-cell></fo:table-row>
				    </xsl:element>
				</xsl:element>
				<xsl:element name="fo:block">
					<xsl:attribute name="id">total-page</xsl:attribute>
				</xsl:element>
			</xsl:element>
			
		</xsl:element>
  
	</fo:root>
 
</xsl:template>

<xsl:template match="Header">

	<xsl:element name="fo:table" use-attribute-sets="text">
  	<xsl:element name="fo:table-column"/>
	<fo:table-body>
	<xsl:element name="fo:table-row">
	<fo:table-cell>
		
		 <xsl:element name="fo:block" use-attribute-sets="header-large-center"><xsl:value-of select="OrgnDetails/OrgnName"/></xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-xsmall-center">(<xsl:value-of select="OrgnDetails/OrgnRegNo"/>)</xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-center"><xsl:value-of select="OrgnDetails/Address1"/></xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-center"><xsl:value-of select="OrgnDetails/Address2"/></xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-center"><xsl:value-of select="OrgnDetails/Address3"/></xsl:element>
		 <xsl:element name="fo:block" use-attribute-sets="text-center">Tel:<xsl:value-of select="OrgnDetails/OrgnRegNo"/>/<xsl:value-of select="OrgnDetails/ContactNo2"/>&#160;Fax:<xsl:value-of select="OrgnDetails/FaxNo1"/></xsl:element>
		<xsl:element name="fo:block"/>
		<fo:block>&#160;</fo:block>
		<xsl:element name="fo:block" use-attribute-sets="header-center">PAYMENT VOUCHER</xsl:element>
		<xsl:element name="fo:block" use-attribute-sets="text">
			<xsl:attribute name="margin-left">5cm</xsl:attribute>
			<fo:table>
				<fo:table-column column-width="2cm"/><fo:table-column/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell><fo:block font-weight="bold">PV&#160;No.</fo:block></fo:table-cell>
						<fo:table-cell><fo:block>: <xsl:value-of select="ReportOptions/DocRefNo"/></fo:block></fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell><fo:block font-weight="bold">Date</fo:block></fo:table-cell>
						<fo:table-cell><fo:block>: <xsl:value-of select="ReportOptions/DocDate"/></fo:block></fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</xsl:element>
	</fo:table-cell>
	</xsl:element>
	<fo:table-row>
		<fo:table-cell>
			<fo:block>
				<fo:table>
					<fo:table-column column-width="15%"/>
					<fo:table-column column-width="5mm"/>
					<fo:table-column/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell font-weight="bold"><fo:block>Pay to</fo:block></fo:table-cell>
							<fo:table-cell font-weight="bold"><fo:block>:</fo:block></fo:table-cell>
							<fo:table-cell border-bottom="solid"><fo:block><xsl:value-of select="ReportOptions/PaymentTo"/></fo:block></fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell font-weight="bold"><fo:block><xsl:value-of select="ReportOptions/CurrencyCode"/></fo:block></fo:table-cell>
							<fo:table-cell font-weight="bold"><fo:block>:</fo:block></fo:table-cell>
							<fo:table-cell border-bottom="solid"><fo:block><xsl:value-of select="ReportOptions/AmountDescription"/></fo:block></fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell font-weight="bold"><fo:block>Account</fo:block></fo:table-cell>
							<fo:table-cell font-weight="bold"><fo:block>:</fo:block></fo:table-cell>
							<fo:table-cell border-bottom="solid"><fo:block><xsl:value-of select="ReportOptions/PaymentTo"/></fo:block></fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:table-cell>
	</fo:table-row>
	<fo:table-row>
		<fo:table-cell>
			<fo:block border-top="solid" border-bottom="solid" font-weight="bold" margin-top="3mm">Description of Payment</fo:block>
			<fo:block margin-top="1mm" margin-bottom="2mm"><xsl:value-of select="ReportOptions/PaymentDescription"/></fo:block>
		</fo:table-cell>
	</fo:table-row>
	</fo:table-body>
	</xsl:element>
	
</xsl:template>
<xsl:template match="Detail[@type='bank']">
	<xsl:element name="fo:table-row">
		<fo:table-cell><fo:block><xsl:value-of select="BankAccount"/></fo:block></fo:table-cell>
		<fo:table-cell><fo:block><xsl:value-of select="PaymentMode"/></fo:block></fo:table-cell>
		<fo:table-cell><fo:block><xsl:value-of select="PaymentRefNo"/></fo:block></fo:table-cell>
		<fo:table-cell><fo:block><xsl:value-of select="TransactionDate"/></fo:block></fo:table-cell>
		<fo:table-cell text-align="right"><fo:block><xsl:value-of select="format-number(Amount,'#,##0.00')"/></fo:block></fo:table-cell>
	</xsl:element>
</xsl:template>
<xsl:template match="Detail[@type='bankTotal']">
	<xsl:element name="fo:table-row" use-attribute-sets="header">
		<fo:table-cell number-columns-spanned="4" text-align="right"><fo:block>TOTAL :</fo:block></fo:table-cell>
		<fo:table-cell text-align="right"><fo:block><xsl:value-of select="format-number(Amount,'#,##0.00')"/></fo:block></fo:table-cell>
	</xsl:element>
</xsl:template>
<xsl:template match="Detail[@type='payFor']">
	<fo:table-row>
		<fo:table-cell><fo:block><xsl:value-of select="DocRef"/></fo:block></fo:table-cell>
		<fo:table-cell><fo:block><xsl:value-of select="Date"/></fo:block></fo:table-cell>
		<fo:table-cell><fo:block><xsl:value-of select="PaymentDescription"/></fo:block></fo:table-cell>
		<fo:table-cell text-align="right"><fo:block><xsl:value-of select="format-number(Amount,'#,##0.00')"/></fo:block></fo:table-cell>
	</fo:table-row>
</xsl:template>
<xsl:template match="Detail[@type='payForTotal']">
	<xsl:element name="fo:table-row" use-attribute-sets="header">
		<fo:table-cell number-columns-spanned="3" text-align="right"><fo:block>TOTAL :</fo:block></fo:table-cell>
		<fo:table-cell text-align="right"><fo:block><xsl:value-of select="format-number(Amount,'#,##0.00')"/></fo:block></fo:table-cell>
	</xsl:element>
</xsl:template>
<xsl:template match="Detail[@type='glPosting']">
	<fo:table-row>
		<fo:table-cell><fo:block><xsl:value-of select="AccountNo"/></fo:block></fo:table-cell>
		<fo:table-cell><fo:block><xsl:value-of select="AccountName"/></fo:block></fo:table-cell>
		<fo:table-cell text-align="right"><fo:block><xsl:if test="AmountDebit!=''"><xsl:value-of select="format-number(AmountDebit,'#,##0.00')"/></xsl:if></fo:block></fo:table-cell>
		<fo:table-cell text-align="right"><fo:block><xsl:if test="AmountCredit!=''"><xsl:value-of select="format-number(AmountCredit,'#,##0.00')"/></xsl:if></fo:block></fo:table-cell>
	</fo:table-row>
</xsl:template>
<xsl:template match="Detail[@type='glPostingTotal']">
	<xsl:element name="fo:table-row" use-attribute-sets="header">
		<fo:table-cell number-columns-spanned="2" text-align="right"><fo:block>TOTAL :</fo:block></fo:table-cell>
		<fo:table-cell text-align="right"><fo:block><xsl:if test="AmountDebit!=''"><xsl:value-of select="format-number(AmountDebit,'#,##0.00')"/></xsl:if></fo:block></fo:table-cell>
		<fo:table-cell text-align="right"><fo:block><xsl:if test="AmountCredit!=''"><xsl:value-of select="format-number(AmountCredit,'#,##0.00')"/></xsl:if></fo:block></fo:table-cell>
	</xsl:element>
</xsl:template>
<xsl:template name="signBox">
	<xsl:param name="msgVal"/>
	
	<fo:table-cell border="solid" height="3.5cm" margin="1mm">
	<fo:block text-align="center" vertical-align="top"><xsl:value-of select="$msgVal"/></fo:block>
	<fo:block height="100%" margin-top="1.8cm" display-align="after">
		<fo:table>
			<fo:table-column column-width="30%"/><fo:table-column column-width="70%"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell><fo:block>Date:</fo:block></fo:table-cell>
					<fo:table-cell border-bottom="solid"><fo:block/></fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</fo:block></fo:table-cell>
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

