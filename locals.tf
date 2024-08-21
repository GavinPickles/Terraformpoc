# Local values for network mapping
locals {
  network_map = {
    "VM Network" = data.vsphere_network.vm_network.id
    "VLAN TRUNK" = data.vsphere_network.vlan_trunk.id
  }
}