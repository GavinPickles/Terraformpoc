#Provider
vsphere_user     = "Administrator@vsphere.local"
vsphere_password = "SuperSecretPassword"
vsphere_server   = "10.200.13.106"

#Infrastructure
vsphere_datacenter      = "Home"
vsphere_host            = "192.168.10.11"
vsphere_compute_cluster = "Home_Cluster"
vsphere_datastore       = "SSD2"

#VM
vm_template_name = "WindowsServer"
vm_guest_id      = "windows2019srvNext_64Guest"
vm_vcpu          = "1"
vm_memory        = "1024"
vm_ipv4_netmask  = "24"
vm_ipv4_gateway  = "192.168.1.1"
vm_dns_servers   = ["8.8.8.8", "8.8.4.4"]
vm_disk_label    = "disk0"
vm_disk_size     = "40"
vm_disk_thin     = "true"
vm_domain        = "domain.tld"
vm_firmware      = "efi"

# VMs Definitions with Multiple Network Interfaces
vms = {
  vm-1 = {
    name       = "vm-1"
    disk0_size = 40
    additional_disks = [
      {
        size             = 2
        thin_provisioned = true
      },
      {
        size             = 3
        thin_provisioned = true
      }
    ]
    network_interfaces = [
      {
        network_name = "VM Network"
        vm_ip        = "192.168.1.10"
        ipv4_netmask = "24"
      },
      {
        network_name = "VLAN TRUNK"
        vm_ip        = "10.10.100.10"
        ipv4_netmask = "24"
      }
    ]
  },
  vm-2 = {
    name       = "vm-2"
    disk0_size = 40
    additional_disks = [
      {
        size             = 2
        thin_provisioned = true
      }
    ]
    network_interfaces = [
      {
        network_name = "VM Network"
        vm_ip        = "192.168.1.20"
        ipv4_netmask = "24"
      },
      {
        network_name = "VLAN TRUNK"
        vm_ip        = "10.10.100.20"
        ipv4_netmask = "24"
      }
    ]
  }
}
