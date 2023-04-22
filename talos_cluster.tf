# Bootstrap the Kubernetes cluster

resource "null_resource" "talos_cluster" {
  depends_on              = [
    proxmox_vm_qemu.talos_controlplane,
    proxmox_vm_qemu.talos_worker
  ]

  triggers  = {
    K8S_CONFIG_SUFFIX=var.K8S_CONFIG_SUFFIX
  }

  provisioner "local-exec" {
    when    = create
    command = <<EOT
    ansible-playbook \
      -i ansible/inventory.yml \
      -e ACTION="bootstrap_cluster" \
      -e K8S_CP_IP_SUFFIX=${var.K8S_CP_IP_SUFFIX} \
      -e NET_IP_PREFIX=${var.NET_IP_PREFIX} \
      -e K8S_CONFIG_SUFFIX=${self.triggers.K8S_CONFIG_SUFFIX} \
      ansible/manage_cluster.yml
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
    ansible-playbook \
      -i ansible/inventory.yml \
      -e ACTION="destroy_cluster" \
      -e K8S_CONFIG_SUFFIX=${self.triggers.K8S_CONFIG_SUFFIX} \
      ansible/manage_cluster.yml
    EOT
  }
}
