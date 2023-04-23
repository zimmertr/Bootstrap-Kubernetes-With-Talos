# Install any optional Talos Addons

resource "null_resource" "talos_addons" {
  depends_on              = [
    null_resource.talos_cluster
  ]

  provisioner "local-exec" {
    when    = create
    command = <<EOT
    ansible-playbook \
      -i ansible/inventory.yml \
      -e ACTION="bootstrap_cluster" \
      -e CILIUM_ENABLE=${var.CILIUM_ENABLE} \
      -e CILIUM_VERSION=${var.CILIUM_VERSION} \
      -e K8S_WORKER_NUM=${var.K8S_WORKER_NUM} \
      -e MAYASTOR_ENABLE=${var.MAYASTOR_ENABLE} \
      -e MAYASTOR_VERSION=${var.MAYASTOR_VERSION} \
      -e K8S_CONFIG_SUFFIX=${var.K8S_CONFIG_SUFFIX} \
      ansible/manage_addons.yml
    EOT
  }
}
