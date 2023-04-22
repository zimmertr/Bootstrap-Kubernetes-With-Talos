# Provision the Kubernetes Worker Node VMs

resource "proxmox_vm_qemu" "talos_worker" {
  depends_on              = [
    null_resource.talos_configs,
    null_resource.talos_template,
    proxmox_vm_qemu.talos_controlplane
  ]
  
  count                   = var.K8S_WORKER_NUM

  vmid                    = var.K8S_WORKER_VMID + count.index
  name                    = "${var.K8S_WORKER_HOSTNAME_PREFIX}-${count.index + 1}-${var.K8S_CONFIG_SUFFIX}"
  desc                    = "${var.K8S_WORKER_HOSTNAME_PREFIX}-${count.index + 1}: ${var.K8S_CONFIG_SUFFIX}"
  # pool                    = var.VM_RESOURCE_POOL

  oncreate                = var.VM_START_ONCREATE
  onboot                  = var.VM_START_ONBOOT

  target_node             = var.PROXMOX_HOST
  clone                   = var.TALOS_TEMPLATE_NAME
  full_clone              = true

  sockets                 = var.K8S_WORKER_SOCKETS
  cores                   = var.K8S_WORKER_CORES
  memory                  = var.K8S_WORKER_MEMORY

  # agent                   = var.VM_ENABLE_QEMU_GUEST_AGENT
  qemu_os                 = "l26"
  scsihw                  = var.STR_SCSI_HW
  cpu                     = "host"
  boot                    = "order=scsi0"

  os_type                 = "cloud-init"
  cloudinit_cdrom_storage = "local"
  cicustom                = "user=local:snippets/talos-${var.K8S_CONFIG_SUFFIX}-worker-${count.index + 1}.yml"
  ipconfig0               = "ip=${var.NET_IP_PREFIX}.${var.K8S_WORKER_IP_SUFFIX + count.index}/${var.NET_SUBNET_SIZE},gw=${var.NET_GATEWAY}"
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
  
  network {
    model                 = var.NET_TYPE
    bridge                = var.NET_BRIDGE
    tag                   = var.NET_VLAN_ID
  }

  # Root Disk
  disk {
    storage               = var.STR_ID
    type                  = var.STR_TYPE
    size                  = var.STR_SIZE
    backup                = var.STR_ENABLE_BACKUPS
    cache                 = var.STR_CACHE_TYPE
    iothread              = var.STR_IO_THREAD
  }  

  # Mayastor Disk
  dynamic "disk" {
    for_each              = var.MAYASTOR_ENABLE == true ? [1] : []
    content {
      storage             = var.MAYASTOR_STR_ID
      type                = var.MAYASTOR_STR_TYPE
      size                = var.MAYASTOR_STR_SIZE
      cache               = var.MAYASTOR_STR_CACHE_TYPE
      iothread            = var.MAYASTOR_STR_IO_THREAD
    }
  }    

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
    ansible-playbook \
      -i ansible/inventory.yml \
      -e K8S_CONFIG_SUFFIX='${trim(split(":", self.desc)[1], " ")}' \
      -e TALOS_MACHINE_NAME='${trim(split(":", self.desc)[0], " ")}' \
      -e TALOS_MACHINE_TYPE="worker" \
      ansible/manage_nodes.yml
    EOT
  }    
}
