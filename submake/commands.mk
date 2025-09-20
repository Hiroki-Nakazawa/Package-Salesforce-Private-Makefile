# Makefile for Salesforce #########################################################################
#  This makefile that executes various tasks in a Salesforce project.
#    Author  : Hiroki Nakazawa
#    Date    : 2025-09-21
###################################################################################################

# *** Phony Targets *******************************************************************************
.PHONY : help update
.PHONY : delta deploy validate

# *** Help Commands *******************************************************************************
help :
	@echo "Makefile for Salesforce Learning Project"
	@echo "  This makefile that executes various tasks in a Salesforce project."
	@echo "    Author  : Hiroki Nakazawa"
	@echo "    Date    : 2025-09-21"
	@echo "--------------------------------------------------"
	@echo "Available Commands:"
	@echo "  update   : Update Salesforce CLI commands and plugins"
	@echo "           :   No variable required"
	@echo "  delta    : Generate a deployment package based on git differences"
	@echo "           :   VERSION          variable is required"
	@echo "           :   FROM_BRANCH_NAME variable is optional (default: origin/main)"
	@echo "           :   TO_BRANCH_NAME   variable is optional (default: origin/release)"
	@echo "           :   OUTPUT_DIRECTORY variable is optional (default: ./package/)"
	@echo "  deploy   : Deploy the generated package to Salesforce org"
	@echo "           :   VERSION                variable is required"
	@echo "           :   AILIAS                 variable is required"
	@echo "           :   DEPLOYMENT_PACKAGE     variable is optional (default: ./package/package.xml)"
	@echo "           :   DEPLOYMENT_DESTRUCTIVE variable is optional (default: ./package/destructiveChanges/destructiveChanges.xml)"
	@echo "           :   TEST_LEVEL			 variable is optional (default: RunLocalTests)"
	@echo "  validate : Validate the generated package in Salesforce org"
	@echo "           :   VERSION                variable is required"
	@echo "           :   AILIAS                 variable is required"
	@echo "           :   VALIDATION_PACKAGE     variable is optional (default: ./package/package.xml)"
	@echo "           :   VALIDATION_DESTRUCTIVE variable is optional (default: ./package/destructiveChanges/destructiveChanges.xml)"
	@echo "           :   TEST_LEVEL             variable is optional (default: RunLocalTests)"
	@echo "--------------------------------------------------"

# *** Salesforce Update Commands ******************************************************************
update :
	@echo "***** Execute Update Command *********************"
	@echo "  Salesforce CLI Commands and Plugins Update"
	@echo "**************************************************"
	@npm update --global @salesforce/cli
	@echo "  Salesforce CLI Commands Updated..."
	@sf plugins update
	@echo "  Salesforce CLI Plugins Updated..."

# *** Delta Commands ******************************************************************************
delta :
	$(call MACRO_VARIABLE_CHECK,$(VERSION),VERSION)
	@echo "***** Execute Delta Command **********************"
	@echo "  Branch From : $(FROM_BRANCH_NAME)"
	@echo "  Branch To   : $(TO_BRANCH_NAME)"
	@echo "  Output Dir  : $(OUTPUT_DIRECTORY)"
	@echo "**************************************************"
	@sf sgd:source:delta --to $(TO_BRANCH_NAME) --from $(FROM_BRANCH_NAME) --output $(OUTPUT_DIRECTORY)
	@echo "  Delta Package Generated..."

# *** Deployment Commands *************************************************************************
deploy :
	$(call MACRO_VARIABLE_CHECK,$(VERSION),VERSION)
	@make delta VERSION=$(VERSION)
	$(call MACRO_VARIABLE_CHECK,$(AILIAS),AILIAS)
	@echo "***** Execute Deployment Command *****************"
	@echo "  Deployment Package     : $(DEPLOYMENT_PACKAGE)"
	@echo "  Deployment Destructive : $(DEPLOYMENT_DESTRUCTIVE)"
	@echo "  Test Level             : $(TEST_LEVEL)"
	@echo "**************************************************"
	@sf project deploy start -x $(DEPLOYMENT_PACKAGE) --post-destructive-changes $(DEPLOYMENT_DESTRUCTIVE) -o $(AILIAS) -l $(TEST_LEVEL)
	@echo "  Deployment Executed..."

# *** Validation Commands *************************************************************************
validate :
	$(call MACRO_VARIABLE_CHECK,$(VERSION),VERSION)
	@make delta VERSION=$(VERSION)
	$(call MACRO_VARIABLE_CHECK,$(AILIAS),AILIAS)
	@echo "***** Execute Validation Command *****************"
	@echo "  Validation Package     : $(VALIDATION_PACKAGE)"
	@echo "  Validation Destructive : $(VALIDATION_DESTRUCTIVE)"
	@echo "  Test Level             : $(TEST_LEVEL)"
	@echo "**************************************************"
	@sf project deploy validate -x $(VALIDATION_PACKAGE) --post-destructive-changes $(VALIDATION_DESTRUCTIVE) -o $(AILIAS) -l $(TEST_LEVEL)
	@echo "  Validation Executed..."
