provider "azurerm" {
    features {
      
    }
}

terraform {
    backend "azurerm" {
        resource_group_name = "terraform-commons"
        storage_account_name = "akrterraformstatefiles"
        container_name = "sampleterraform"
        key = "dev.tfstate"
    }
}

resource "azurerm_resource_group" "akr-sampleterraform-rg" {
    name = "akr-sampleterraform-rg"
    location = "westeurope"
}

resource "azurerm_container_group" "akr-sampleterraform-cg" {
    name = "akr-sampleterraform-cg"
    location = azurerm_resource_group.akr-sampleterraform-rg.location
    resource_group_name = azurerm_resource_group.akr-sampleterraform-rg.name

    ip_address_type = "Public"
    dns_name_label = "krajniak"
    os_type = "Linux"

    container {
        name = "sampleterraform"
        image = "krajniak/sampleterraform"
        cpu =  "1"
        memory = "1"

        ports {
            port = 80
            protocol = "TCP"
        }
    }
}



