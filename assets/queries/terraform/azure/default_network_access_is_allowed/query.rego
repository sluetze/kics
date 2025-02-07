package Cx

import data.generic.terraform as tf_lib
import data.generic.common as common_lib

CxPolicy[result] {
	resource := input.document[i].resource.azurerm_storage_account_network_rules[name]
	resource.default_action == "Allow"

	result := {
		"documentId": input.document[i].id,
		"resourceType": "azurerm_storage_account_network_rules",
		"resourceName": tf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("azurerm_storage_account_network_rules[%s].default_action", [name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("'azurerm_storage_account_network_rules[%s].default_action' is set to 'Deny'", [name]),
		"keyActualValue": sprintf("'azurerm_storage_account_network_rules[%s].default_action' is set to 'Allow'", [name]),
		"searchLine": common_lib.build_search_line(["resource","azurerm_storage_account_network_rules" ,name, "default_action"], []),
		"remediation": json.marshal({
			"before": "Allow",
			"after": "Deny"
		}),
		"remediationType": "replacement",
	}
}
