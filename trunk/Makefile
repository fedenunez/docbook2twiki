#
# File: Makefile
#
# $Id$
#

XMLFILE=test

all: test-twiki test-cfl

test-twiki:
	xsltproc --output $(XMLFILE).twiki docbook2twiki.xsl $(XMLFILE).xml

test-cfl:
	xsltproc --output $(XMLFILE).wiki docbook2cfl.xsl $(XMLFILE).xml
