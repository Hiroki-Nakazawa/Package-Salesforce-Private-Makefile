# Makefile for Salesforce #########################################################################
#  This makefile that executes various tasks in a Salesforce project.
#    Author  : Hiroki Nakazawa
#    Date    : 2025-09-21
###################################################################################################

# *** Variable Check Macro ************************************************************************
MACRO_VARIABLE_CHECK = @if test "$(1)" = DAMMY; then echo "Please set $(2) $(1) variable"; exit 1; fi