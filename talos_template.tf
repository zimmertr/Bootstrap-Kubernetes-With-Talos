# Provision the Talos Template used by the Kubernetes Control Plane and Worker Node VMs

# telmate/proxmox is not capable of using `disk import` as a VM creation strategy; only clone/iso. 
# Therefore it is necesssary to use Ansible to execute `qm` commands to create the template instead. 
resource "null_resource" "talos_template" {
  triggers  = {
    RESOURCE_POOL = var.VM_RESOURCE_POOL
    TEMPLATE_VMID = var.TALOS_TEMPLATE_VMID
  }

  provisioner "local-exec" {
    when    = create
    command = <<EOT
    ansible-playbook \
      -i ansible/inventory.yml \
      -e ACTION="create_template" \
      -e TALOS_VERSION=${var.TALOS_VERSION} \
      -e RESOURCE_POOL=${self.triggers.RESOURCE_POOL} \
      -e TEMPLATE_PATH=${var.TALOS_TEMPLATE_PATH} \
      -e TEMPLATE_NAME=${var.TALOS_TEMPLATE_NAME} \
      -e TEMPLATE_STORAGE_ID=${var.STR_ID} \
      -e TEMPLATE_VMID=${self.triggers.TEMPLATE_VMID} \
      ansible/manage_template.yml
    EOT
  }
  
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
    ansible-playbook \
      -i ansible/inventory.yml \
      -e ACTION="destroy_template" \
      -e RESOURCE_POOL=${self.triggers.RESOURCE_POOL} \
      -e TEMPLATE_VMID=${self.triggers.TEMPLATE_VMID} \
      ansible/manage_template.yml
    EOT
  }
}
