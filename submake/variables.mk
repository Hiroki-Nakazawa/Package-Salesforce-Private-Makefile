# Makefile for Salesforce #########################################################################
#  This makefile that executes various tasks in a Salesforce project.
#    Author  : Hiroki Nakazawa
#    Date    : 2025-09-21
###################################################################################################

# *** Project Information *************************************************************************
AILIAS  = DAMMY
VERSION = DAMMY

# *** Directory Variables *************************************************************************
DIR_ROOT      = ./
DIR_SEPARATOR = /
DIR_PACKAGE   = $(DIR_ROOT)package

# *** File Structure ******************************************************************************
FILE_XML_PACKAGE     = $(DIR_PACKAGE)$(DIR_SEPARATOR)package/package.xml
FILE_XML_DESTRUCTIVE = $(DIR_PACKAGE)$(DIR_SEPARATOR)destructiveChanges/destructiveChanges.xml

# *** Github Branch Structure *********************************************************************
GIT_ORIGIN         = origin
GIT_DEFAULT_BRANCH = main
GIT_RELEASE_BRANCH = release

# *** Salesforce Delta Commands *******************************************************************
FROM_BRANCH_NAME = $(GIT_ORIGIN)$(DIR_SEPARATOR)$(GIT_DEFAULT_BRANCH)
TO_BRANCH_NAME   = $(GIT_ORIGIN)$(DIR_SEPARATOR)$(GIT_RELEASE_BRANCH)$(DIR_SEPARATOR)$(VERSION)
OUTPUT_DIRECTORY = $(DIR_PACKAGE)$(DIR_SEPARATOR)

# *** Salesforce Deployment and Validation Commands ***********************************************
DEPLOYMENT_PACKAGE     = $(FILE_XML_PACKAGE)
VALIDATION_PACKAGE     = $(FILE_XML_PACKAGE)
DEPLOYMENT_DESTRUCTIVE = $(FILE_XML_DESTRUCTIVE)
VALIDATION_DESTRUCTIVE = $(FILE_XML_DESTRUCTIVE)
TEST_LEVEL             = RunLocalTests