<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:param name="logoImg"/>
<xsl:key name="by-row" match="Detail" use="@Row"/>

<xsl:attribute-set name="tablecell-style">
	<xsl:attribute name="border">solid</xsl:attribute>
	<xsl:attribute name="border-width">0.1mm</xsl:attribute>
	<xsl:attribute name="text-align">right</xsl:attribute>
	<xsl:attribute name="padding-top">1mm</xsl:attribute>
</xsl:attribute-set>
		
<xsl:attribute-set name="text-style">
	<xsl:attribute name="font-size">14pt</xsl:attribute>
	<xsl:attribute name="font-family">Times New Roman</xsl:attribute>
	<xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>
	
<xsl:attribute-set name="text1-style">
	<xsl:attribute name="font-size">10.3pt</xsl:attribute>
	<xsl:attribute name="font-family">Times New Roman</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="text2-style">
	<xsl:attribute name="font-size">10.3pt</xsl:attribute>
	<xsl:attribute name="font-family">Times New Roman</xsl:attribute>
	<xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="text3-style">
	<xsl:attribute name="font-size">8pt</xsl:attribute>
	<xsl:attribute name="font-family">Times New Roman</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="td_align_right">
	<xsl:attribute name="border-top-style">solid</xsl:attribute>
	<xsl:attribute name="border-bottom-style">solid</xsl:attribute>
	<xsl:attribute name="border-left-style">solid</xsl:attribute>
	<xsl:attribute name="border-right-style">solid</xsl:attribute>
	<xsl:attribute name="text-align">right</xsl:attribute>
</xsl:attribute-set>
 
<xsl:template match="Documents">
	
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
						<xsl:attribute name="margin-top">11.1cm</xsl:attribute>
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
				<fo:block-container height="8.3cm">
					<xsl:apply-templates select="//Header"/> 
				</fo:block-container>
				<xsl:call-template name="CreditLimit"/>
				<xsl:call-template name="tableHeader"/>
			</xsl:element>
			
			 <xsl:element name="fo:static-content">
				<xsl:attribute name="flow-name">xsl-region-after</xsl:attribute>
					<xsl:element name="fo:block" use-attribute-sets="text3-style">
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
		
		 <xsl:element name="fo:block"><xsl:value-of select="OrgnDetails/OrgnName"/></xsl:element>
		 <xsl:element name="fo:block"><xsl:value-of select="OrgnDetails/OrgnRegNo"/></xsl:element>
		 <xsl:element name="fo:block"><xsl:value-of select="OrgnDetails/Address1"/></xsl:element>
		 <xsl:element name="fo:block"><xsl:value-of select="OrgnDetails/Address2"/></xsl:element>
		 <xsl:element name="fo:block"><xsl:value-of select="OrgnDetails/Address3"/></xsl:element>
		 <xsl:element name="fo:block">Tel:<xsl:value-of select="OrgnDetails/OrgnRegNo"/>/<xsl:value-of select="OrgnDetails/ContactNo2"/>&#160;Fax:<xsl:value-of select="OrgnDetails/FaxNo1"/></xsl:element>
		
		<xsl:element name="fo:block">Accounts Payable</xsl:element>
		<xsl:element name="fo:block">Journal Voucher</xsl:element>
		<xsl:element name="fo:table">
			<xsl:element name="fo:table-column"/>
			<xsl:element name="fo:table-column"/>
			<xsl:element name="fo:table-column"/>
			<xsl:element name="fo:table-column"/>
			<xsl:element name="fo:table-body">
				<xsl:element name="fo:table-row">
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Account No.</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">: <xsl:value-of select="ReportOptions/AccountNo"/></xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Voucher No.</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">: <xsl:value-of select="ReportOptions/VoucherNo"/></xsl:element></xsl:element>
				</xsl:element>
				<xsl:element name="fo:table-row">
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Account Name</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">: <xsl:value-of select="ReportOptions/Accountname"/></xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Voucher Date</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">: <xsl:value-of select="ReportOptions/VoucherDate"/></xsl:element></xsl:element>
				</xsl:element>
				<xsl:element name="fo:table-row">
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Description</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">: <xsl:value-of select="ReportOptions/DocDescription"/></xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">Reference No.</xsl:element></xsl:element>
					<xsl:element name="fo:table-cell"><xsl:element name="fo:block">: <xsl:value-of select="ReportOptions/ReferenceNo"/></xsl:element></xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:element>
	</xsl:element>
	</xsl:element>
	</xsl:element>
	
</xsl:template>

<xsl:template name="CreditLimit">
	<xsl:element name="fo:block" use-attribute-sets="text1-style">
		<xsl:attribute name="space-before.optimum">8pt</xsl:attribute>	
		<xsl:attribute name="space-after.optimum">8pt</xsl:attribute>
		<fo:block start-indent="0.85cm">
		<xsl:attribute name="space-after.optimum">3pt</xsl:attribute>
		Credit Limit: <xsl:value-of select="//Header/AccountCreditLimit"/> (
		<xsl:value-of select="//Header/AccountBankGuarenteeNumber"/>)
		</fo:block>
		<fo:table>
			<fo:table-body>
			<fo:table-row>
				<xsl:for-each select="//Aging/AgingAmount">
					<xsl:element name="fo:table-cell" use-attribute-sets="td_align_right">
						<fo:block font-weight="bold">
						<xsl:value-of select="@Period"/>
						</fo:block>
					</xsl:element>
				</xsl:for-each>
				<xsl:element name="fo:table-cell" use-attribute-sets="td_align_right">
					<fo:block font-weight="bold">
					Balance
					</fo:block>
				</xsl:element>
			</fo:table-row>
			<fo:table-row>
				<xsl:for-each select="//Aging/AgingAmount">
					<xsl:element name="fo:table-cell">
						<xsl:attribute name="text-align">right</xsl:attribute>
						<fo:block font-weight="bold">
							<xsl:value-of select="."/>
						</fo:block>
					</xsl:element>
				</xsl:for-each>
				<fo:table-cell text-align="right">
					<fo:block font-weight="bold">
						<xsl:call-template name="formatNumber">
							<xsl:with-param name="val">
								<xsl:variable name="totalDebit" select="sum(//Detail[generate-id()=generate-id(key('by-row',@Row))]/EntryDebit)"/>
								<xsl:variable name="totalCredit" select="sum(//Detail[generate-id()=generate-id(key('by-row',@Row))]/EntryCredit)"/>
								<xsl:value-of select="$totalDebit - $totalCredit"/>
							</xsl:with-param>
							<xsl:with-param name="format">#,##0.00</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</fo:table-cell>
			</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:element>
</xsl:template>

<xsl:template name="tableHeader">
	<fo:block font-size="10.3pt">
	<fo:table>
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">20%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">20%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>

	<xsl:element name="fo:table-body">
    <xsl:element name="fo:table-row">
		<xsl:attribute name="border-bottom">solid</xsl:attribute>
		
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text2-style">
					Doc Date
				</xsl:element>
			</xsl:element>
			
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text2-style">
					Document No.
				</xsl:element>
			</xsl:element>
			
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text2-style">
					Due Date
				</xsl:element>
			</xsl:element>
			
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text2-style">
					Description
				</xsl:element>
			</xsl:element>
			
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text2-style">
					<xsl:attribute name="text-align">right</xsl:attribute>
					Age(Days)
				</xsl:element>
			</xsl:element>
			
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text2-style">
					<xsl:attribute name="text-align">right</xsl:attribute>
					Debit
				</xsl:element>
			</xsl:element>
	
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text2-style">
					<xsl:attribute name="text-align">right</xsl:attribute>
					Credit
				</xsl:element>
			</xsl:element>
			
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text2-style">
					<xsl:attribute name="text-align">right</xsl:attribute>
					Balance
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
  	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">20%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">20%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>
	
	<xsl:element name="fo:table-column">
		<xsl:attribute name="column-width">10%</xsl:attribute>
	</xsl:element>

	<xsl:element name="fo:table-body">
    
	<xsl:for-each select="//Detail[generate-id()=generate-id(key('by-row',@Row))]">
		<!--<xsl:sort select="EntryDate"/>-->
		<xsl:element name="fo:table-row">
	
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text1-style">
					<xsl:value-of select="key('by-row',@Row)/EntryDate"/>
				</xsl:element>
			</xsl:element>
	
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text1-style">
					<xsl:value-of select="key('by-row',@Row)/EntryReference"/>
				</xsl:element>
			</xsl:element>
	
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text1-style">
				<xsl:value-of select="key('by-row',@Row)/DueDate"/>
				</xsl:element>
			</xsl:element>
	
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text1-style">
					<xsl:value-of select="key('by-row',@Row)/Description"/>
				</xsl:element>
			</xsl:element>
	
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text1-style">
				<xsl:attribute name="text-align">right</xsl:attribute>
				<xsl:call-template name="formatNumber">
					<xsl:with-param name="val" select="Age">
					<!--<xsl:call-template name="getDateDiffInDays">
						<xsl:with-param name="stDate" select="key('by-row',@Row)/EntryDate"/>
						<xsl:with-param name="endDate" select="//AsAtDate"/>
					</xsl:call-template>-->
					</xsl:with-param>
					<xsl:with-param name="format">##</xsl:with-param>
					<xsl:with-param name="printZero">yes</xsl:with-param>
				</xsl:call-template>
				</xsl:element>
			</xsl:element>
	
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text1-style">
					<xsl:attribute name="text-align">right</xsl:attribute>
					<xsl:call-template name="formatNumber">
						<xsl:with-param name="val" select="key('by-row',@Row)/EntryDebit"/>
						<xsl:with-param name="format">#,##0.00</xsl:with-param>
						<xsl:with-param name="printZero">yes</xsl:with-param>
					</xsl:call-template>
				</xsl:element>
			</xsl:element>
	
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text1-style">
					<xsl:attribute name="text-align">right</xsl:attribute>
					<xsl:call-template name="formatNumber">
						<xsl:with-param name="val" select="key('by-row',@Row)/EntryCredit"/>
						<xsl:with-param name="format">#,##0.00</xsl:with-param>
						<xsl:with-param name="printZero">yes</xsl:with-param>
					</xsl:call-template>
				</xsl:element>
			</xsl:element>
	
			<xsl:element name="fo:table-cell">
				<xsl:element name="fo:block" use-attribute-sets="text1-style">
					<xsl:attribute name="text-align">right</xsl:attribute>
					<xsl:call-template name="formatNumber">
						<xsl:with-param name="val">
							<xsl:call-template name="accumulateBalance">
								<xsl:with-param name="row" select="@Row"/>
								<xsl:with-param name="currSum">0</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="format">#,##0.00</xsl:with-param>
						<xsl:with-param name="printZero">yes</xsl:with-param>
					</xsl:call-template>
				</xsl:element>
			</xsl:element>
	
			</xsl:element>
	
	</xsl:for-each>
	
	<fo:table-row>
		<fo:table-cell number-columns-spanned="5">
			<xsl:element name="fo:block" use-attribute-sets="text1-style">
				<xsl:attribute name="text-align">right</xsl:attribute>
				Total
			</xsl:element>
		</fo:table-cell>
		<xsl:variable name="totalDebit" select="sum(//Detail[generate-id()=generate-id(key('by-row',@Row))]/EntryDebit)"/>
		<xsl:variable name="totalCredit" select="sum(//Detail[generate-id()=generate-id(key('by-row',@Row))]/EntryCredit)"/>
		<fo:table-cell>
			<xsl:element name="fo:block" use-attribute-sets="text1-style">
				<xsl:attribute name="text-align">right</xsl:attribute>
				<xsl:call-template name="formatNumber">
					<xsl:with-param name="val" select="$totalDebit"/>
					<xsl:with-param name="format">#,##0.00</xsl:with-param>
					<xsl:with-param name="printZero">yes</xsl:with-param>
				</xsl:call-template>
			</xsl:element>
		</fo:table-cell>
		<fo:table-cell>
			<xsl:element name="fo:block" use-attribute-sets="text1-style">
				<xsl:attribute name="text-align">right</xsl:attribute>
				<xsl:call-template name="formatNumber">
					<xsl:with-param name="val" select="$totalCredit"/>
					<xsl:with-param name="format">#,##0.00</xsl:with-param>
					<xsl:with-param name="printZero">yes</xsl:with-param>
				</xsl:call-template>
			</xsl:element>
		</fo:table-cell>
		<fo:table-cell>
			<xsl:element name="fo:block" use-attribute-sets="text1-style">
				<xsl:attribute name="text-align">right</xsl:attribute>
				<xsl:call-template name="formatNumber">
					<xsl:with-param name="val" select="$totalDebit - $totalCredit"/>
					<xsl:with-param name="format">#,##0.00</xsl:with-param>
					<xsl:with-param name="printZero">yes</xsl:with-param>
				</xsl:call-template>
			</xsl:element>
		</fo:table-cell>
	</fo:table-row>
	</xsl:element>
	
	</xsl:element>

</fo:block>
</xsl:template>

<xsl:template name="accumulateBalance">
	<xsl:param name="row"/>
	<xsl:param name="currSum"/>
	<xsl:variable name="currVal">
		<xsl:value-of select="key('by-row',$row)/EntryDebit - key('by-row',$row)/EntryCredit"/>
	</xsl:variable>
	<xsl:variable name="cycleSum" select="$currSum + $currVal"/>
	<xsl:choose>
		<xsl:when test="number($row) &gt; 1">
			<xsl:call-template name="accumulateBalance">
				<xsl:with-param name="row" select="number($row) - 1"/>
				<xsl:with-param name="currSum" select="$cycleSum"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$cycleSum"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="Header/ReportOptions">

	<xsl:element name="fo:table">
	<xsl:attribute name="border">solid</xsl:attribute>
	<xsl:attribute name="padding-left">1pt</xsl:attribute>
	<xsl:attribute name="space-after.optimum">15pt</xsl:attribute>
  
	<xsl:element name="fo:table-column">
	</xsl:element>

	<xsl:element name="fo:table-body">
	
	<xsl:element name="fo:table-row">
	
	<xsl:element name="fo:table-cell">
	
	<xsl:element name="fo:block" use-attribute-sets="text1-style">
		a) Please settle your long outstanding balance immediately and please be informed that accounts with outstanding debit
	</xsl:element>
						
	<xsl:element name="fo:block" use-attribute-sets="text1-style">
		balance of more than 56 days will be suspended without further notice.
	</xsl:element>
	
	<xsl:element name="fo:block" use-attribute-sets="text1-style">
		b) Any credit balance after 3 months will be used to offset any debit balance without further notice.
	</xsl:element>

	<xsl:element name="fo:block" use-attribute-sets="text1-style">
		c) Please contact the respective port for the enquiry on bilings:-
	</xsl:element>		

	<xsl:element name="fo:block" use-attribute-sets="text1-style">
		Kota Kinabalu: 088-538645, Kudat: 088-611261, Sapangar Oil Terminal: 088-411069, Sapangar Container Port: 088-483301,
		L.Datu/Kunak: 089-889720, Sandakan: 089-612411, Tawau: 089-773700
	</xsl:element>
	
	</xsl:element>
	
	</xsl:element>
	
	</xsl:element>
	
	</xsl:element>
		
		<xsl:element name="fo:block" use-attribute-sets="text3-style">
			<xsl:attribute name="border-top-style">solid</xsl:attribute>
			<xsl:attribute name="padding-top">1mm</xsl:attribute>
				Date Printed:
					<xsl:element name="fo:inline">
						<xsl:attribute name="space-start">0.5mm</xsl:attribute>
						<xsl:attribute name="space-end">5mm</xsl:attribute>
							<xsl:value-of select="PrintedAt"/>
					</xsl:element> 
				Printed By:
					<xsl:element name="fo:inline">
						<xsl:attribute name="space-start">0.5mm</xsl:attribute>
							<xsl:value-of select="PrintedBy"/>
					</xsl:element> 
		</xsl:element>

</xsl:template>

<xsl:template name="getMonth">

	<xsl:param name="val"/> 
		<xsl:choose>
			<xsl:when test="number($val) = 1">Jan</xsl:when> 
			<xsl:when test="number($val) = 2">Feb</xsl:when> 
			<xsl:when test="number($val) = 3">Mar</xsl:when> 
			<xsl:when test="number($val) = 4">Apr</xsl:when> 
			<xsl:when test="number($val) = 5">May</xsl:when> 
			<xsl:when test="number($val) = 6">Jun</xsl:when> 
			<xsl:when test="number($val) = 7">Jul</xsl:when> 
			<xsl:when test="number($val) = 8">Aug</xsl:when> 
			<xsl:when test="number($val) = 9">Sept</xsl:when> 
			<xsl:when test="number($val) = 10">Oct</xsl:when> 
			<xsl:when test="number($val) = 11">Nov</xsl:when> 
			<xsl:when test="number($val) = 12">Dec</xsl:when> 
			<xsl:otherwise/> 
		</xsl:choose>
			
</xsl:template>

<!--<xsl:template name="getDateDiffInDays">
	<xsl:param name="stDate"/>
	<xsl:param name="endDate"/>
	<xsl:variable name="stDay" select="substring($stDate,1,2)"/>
	<xsl:variable name="stMon" select="substring($stDate,4,2)"/>
	<xsl:variable name="stYr" select="substring($stDate,7,4)"/>
	<xsl:variable name="endDay" select="substring($endDate,1,2)"/>
	<xsl:variable name="endMon" select="substring($endDate,4,2)"/>
	<xsl:variable name="endYr" select="substring($endDate,7,4)"/>
	<xsl:variable name="numDaysStart" select="$stDay + ($stMon - 1) * 30.4167 + ($stYr - 1) * 365.25"/>
	<xsl:variable name="numDaysEnd" select="$endDay + ($endMon - 1) * 30.4167 + ($endYr - 1) * 365.25"/>
	<xsl:variable name="date1" select="xs:date(concat($stYr,'-',$stMon,'-',$stDay))"/>
	<xsl:variable name="date2" select="xs:date(concat($endYr,'-',$endMon,'-',$endDay))"/>
	<xsl:sequence select="($date2 - $date1) div xs:dayTimeDuration('P1D')"/>
</xsl:template>-->

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