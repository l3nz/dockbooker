<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

    <!-- We want to process docbooks. So we include the main xsl for this type of documents -->                
    <xsl:import href="##XSLDOCBOOK##/fo/docbook.xsl"/>

    <!-- This is required to customize the title page. This file is auto-generated starting from the titlepage.xml -->
    <xsl:include href="titlepage.xsl"/>

    <!-- Define here the location where the cover and header images are places -->
    <xsl:variable name="cover.image.filename">##HOME##/Pictures/pdf-style/LowayCover.jpg</xsl:variable>
    <xsl:variable name="header.image.filename">##HOME##/Pictures/pdf-style/Loway.jpg</xsl:variable>

    <!-- This prevents the text justification of the document -->
    <xsl:attribute-set name="root.properties">
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>

    <!-- Enable the page number list in any xref cross reference -->
    <xsl:param name="insert.xref.page.number">yes</xsl:param>

    <!-- Inserting <?hard-pagebreak?> in our documents generate a forced page break -->
    <xsl:template match="processing-instruction('hard-pagebreak')">
      <fo:block break-after='page'/>
    </xsl:template>

    <!-- We would like to show a cover image instead of the author in the main titlepage -->
    <xsl:template match="author" mode="book.titlepage.recto.mode">
      <fo:external-graphic content-height="8.0cm">
        <xsl:attribute name="src">
          <xsl:call-template name="fo-external-image">
            <xsl:with-param name="filename" select="$cover.image.filename"/>
          </xsl:call-template>
        </xsl:attribute>
      </fo:external-graphic>
    </xsl:template>

    <!-- Modify the header and the footer contents -->
    <xsl:param name="header.column.widths">2 1 1</xsl:param>
    <xsl:template name="header.content">
        <xsl:param name="pageclass" select="''"/>
        <xsl:param name="sequence" select="''"/>
        <xsl:param name="position" select="''"/>
        <xsl:param name="gentext-key" select="''"/>
        
        <fo:block>
            <!-- Sequence can bve off, even, first, blank -->
            <!-- position can be left, center, right -->
            <xsl:choose>
                
                <xsl:when test="$sequence = 'odd' and $position = 'left'">
                    <fo:retrieve-marker retrieve-class-name="section.head.marker"
                                        retrieve-position="first-including-carryover"
                                        retrieve-boundary="page-sequence"/>
                </xsl:when>
                
                <xsl:when test="$sequence = 'odd' and $position = 'center'">
                    <xsl:call-template name="draft.text"/>
                </xsl:when>
                
                <xsl:when test="$sequence = 'odd' and $position = 'right'">
                    <fo:page-number/>
                </xsl:when>
                
                <xsl:when test="$sequence = 'even' and $position = 'left'">
                    <fo:page-number/>
                </xsl:when>
                
                <xsl:when test="$sequence = 'even' and $position = 'center'">
                    <xsl:call-template name="draft.text"/>
                </xsl:when>
                
                <xsl:when test="$sequence = 'even' and $position = 'right'">
                    <xsl:apply-templates select="." mode="titleabbrev.markup"/>
                </xsl:when>
                
                <xsl:when test="$sequence = 'blank' and $position = 'center'">
                    <xsl:text>This page intentionally left blank</xsl:text>
                </xsl:when>
                
            </xsl:choose>
        </fo:block>
    </xsl:template>

    <xsl:param name="region.after.extent">1.3cm</xsl:param>
    <xsl:template name="footer.content">
        <xsl:param name="pageclass" select="''"/>
        <xsl:param name="sequence" select="''"/>
        <xsl:param name="position" select="''"/>
        <xsl:param name="gentext-key" select="''"/>
        
        <fo:block>
            <!-- Sequence can bve off, even, first, blank -->
            <!-- position can be left, center, right -->
            <xsl:choose>
                
                <xsl:when test="$position = 'center'">
                    <fo:external-graphic content-height="1.0cm">
                        <xsl:attribute name="src">
                            <xsl:call-template name="fo-external-image">
                                <xsl:with-param name="filename" select="$header.image.filename"/>
                            </xsl:call-template>
                        </xsl:attribute>
                    </fo:external-graphic>
                </xsl:when>
            
            </xsl:choose>
        </fo:block>
        
    </xsl:template>

</xsl:stylesheet>
