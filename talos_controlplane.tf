# Provision the Kubernetes Control Plane VMs

resource "proxmox_vm_qemu" "talos_controlplane" {
  depends_on              = [
    null_resource.talos_configs,
    null_resource.talos_template
  ]

  count                   = var.K8S_CP_NUM

  vmid                    = var.K8S_CP_VMID + count.index 
  name                    = "${var.K8S_CP_HOSTNAME_PREFIX}-${count.index + 1}-${var.K8S_CONFIG_SUFFIX}"
  desc                    = "${var.K8S_CP_HOSTNAME_PREFIX}-${count.index + 1}: ${var.K8S_CONFIG_SUFFIX}"
  # pool                    = var.VM_RESOURCE_POOL

  oncreate                = var.VM_START_ONCREATE
  onboot                  = var.VM_START_ONBOOT

  target_node             = var.PROXMOX_HOST
  clone                   = var.TALOS_TEMPLATE_NAME
  full_clone              = true

  sockets                 = var.K8S_CP_SOCKETS
  cores                   = var.K8S_CP_CORES
  memory                  = var.K8S_CP_MEMORY

  # agent                   = var.VM_ENABLE_QEMU_GUEST_AGENT
  qemu_os                 = "l26"
  scsihw                  = var.STR_SCSI_HW
  cpu                     = "host"
  boot                    = "order=scsi0"

  os_type                 = "cloud-init"
  cloudinit_cdrom_storage = "local"
  cicustom                = "user=local:snippets/talos-${var.K8S_CONFIG_SUFFIX}-controlplane-${count.index + 1}.yml"
  ipconfig0               = "ip=${var.NET_IP_PREFIX}.${var.K8S_CP_IP_SUFFIX + count.index}/${var.NET_SUBNET_SIZE},gw=${var.NET_GATEWAY}"
  ipconfig1               = "ip=${var.NET_IP_PREFIX}.${var.K8S_CP_VIP_SUFFIX}/${var.NET_SUBNET_SIZE},gw=${var.NET_GATEWAY}"
  nameserver              = var.NET_NAMESERVER
  searchdomain            = var.NET_SEARCH_DOMAIN

  # vga {
  #   memory                = 0
  #   type                  = "serial0"
  # }

  # serial {
  #   id                    = 0
  #   type                  = "socket"
  # }
  
  # Primary Interface
  network {
    model                 = var.NET_TYPE
    bridge                = var.NET_BRIDGE
    tag                   = var.NET_VLAN_ID
  }

  # Shared VIP Interface
  network {
    model                 = var.NET_TYPE
    bridge                = var.NET_BRIDGE
    tag                   = var.NET_VLAN_ID
  }

  disk {
    storage               = var.STR_ID
    type                  = var.STR_TYPE
    size                  = var.STR_SIZE
    backup                = var.STR_ENABLE_BACKUPS
    cache                 = var.STR_CACHE_TYPE
    iothread              = var.STR_IO_THREAD
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
    ansible-playbook \
      -i ansible/inventory.yml \
      -e K8S_CONFIG_SUFFIX='${trim(split(":", self.desc)[1], " ")}' \
      -e TALOS_MACHINE_NAME='${trim(split(":", self.desc)[0], " ")}' \
      -e TALOS_MACHINE_TYPE="controlplane" \
      ansible/manage_nodes.yml
    EOT
  }    
}
