resource "vsphere_virtual_machine" "vm" {
  for_each = var.vms

  name             = each.value.name
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
  guest_id         = var.vm_guest_id
  num_cpus         = var.vm_vcpu
  memory           = var.vm_memory
  firmware         = var.vm_firmware

  # Primary disk configuration
  disk {
    label            = "${each.value.name}_disk0" 
    size             = each.value.disk0_size
    thin_provisioned = var.vm_disk_thin
    unit_number      = 0
  }

  # Additional disks configuration
  dynamic "disk" {
    for_each = each.value.additional_disks
    content {
      label            = join("_", [each.value.name, "disk,${disk.key + 1}"]) 
      size             = disk.value.size
      thin_provisioned = disk.value.thin_provisioned
      unit_number      = disk.key + 1 // Ensure unique SCSI unit number
    }
  }

  dynamic "network_interface" {
    for_each = each.value.network_interfaces
    content {
      network_id   = lookup(local.network_map, network_interface.value.network_name)
      adapter_type = "vmxnet3" // Hardcoded adapter type for simplicity
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      windows_options {
        computer_name = each.value.name
        workgroup     = var.vm_domain
      }

      ipv4_gateway = var.vm_ipv4_gateway

      dynamic "network_interface" {
        for_each = each.value.network_interfaces
        content {
          ipv4_address = network_interface.value.vm_ip
          ipv4_netmask = network_interface.value.ipv4_netmask
          dns_server_list =  network_interface.key == 0 ? var.vm_dns_servers : null
        }
      }   
    }
  }
}

