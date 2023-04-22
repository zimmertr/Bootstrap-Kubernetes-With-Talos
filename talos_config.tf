# Provision the boilerplate Talos configuration

resource "null_resource" "talos_configs" {
  provisioner "local-exec" {
    when    = create
    command = <<EOT
    ansible-playbook \
      -i ansible/inventory.yml \
      -e K8S_CLUSTER_NAME=${var.K8S_CLUSTER_NAME} \
      -e K8S_CP_HOSTNAME_PREFIX=${var.K8S_CP_HOSTNAME_PREFIX} \
      -e K8S_CP_NUM=${var.K8S_CP_NUM} \
      -e K8S_CP_VIP_SUFFIX=${var.K8S_CP_VIP_SUFFIX} \
      -e K8S_CNI_DISABLE=${var.K8S_CNI_DISABLE} \
      -e K8S_WORKER_HOSTNAME_PREFIX=${var.K8S_WORKER_HOSTNAME_PREFIX} \
      -e K8S_WORKER_NUM=${var.K8S_WORKER_NUM} \
      -e MAYASTOR_ENABLE="${var.MAYASTOR_ENABLE}" \
      -e MAYASTOR_ISCSI_TOOLS_VERSION=${var.MAYASTOR_ISCSI_TOOLS_VERSION} \
      -e NET_IP_PREFIX=${var.NET_IP_PREFIX} \
      -e TALOS_ADDITIONAL_GEN_CONFIG_OPTIONS=${var.TALOS_ADDITIONAL_GEN_CONFIG_OPTIONS} \
      -e K8S_CONFIG_SUFFIX=${var.K8S_CONFIG_SUFFIX} \
      ansible/manage_configs.yml
    EOT
  }
}
