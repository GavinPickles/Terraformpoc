terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~=2.0.0"
      # fixed to 2.0 major but latest minor release of 2.x.x
    }
  }
}

# Provider settings
provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}
