##################################################
#         Proxmox Provider Configuration         #
##################################################
variable "PROXMOX_ALLOW_INSECURE" {
  type        = bool
  default     = false
  description = "Whether or not it should be allowed for Terraform to connect to Proxmox without a trusted SSL certificate authority."
}
variable "PROXMOX_API_TIMEOUT" {
  type        = number
  default     = 300
  description = "The timeout value (expressed in seconds) for Proxmox API calls."
}
variable "PROXMOX_HOST" {
  type        = string
  description = "The hostname of the target Proxmox cluster."
}
variable "PROXMOX_NUM_PROCESSES" {
  type        = number
  default     = 4
  description = "The number of simultaneous Proxmox actions that can occur. (EG: Creating multiple resources)"
}
variable "PROXMOX_PORT" {
  type        = number
  default     = 8006
  description = "The port used to network with the Proxmox API endpoint. "
}


##################################################
#              Talos Configuration               #
##################################################
variable "TALOS_ADDITIONAL_GEN_CONFIG_OPTIONS" {
  type        = string
  default     = ""
  description = "Series of additional arguments to pass to the talos gen config command"
}
variable "TALOS_VERSION" {
  type        = string
  default     = "v1.3.7"
  description = "The version of Talos to use."
}


##################################################
#             Template Configuration             #
##################################################
variable "TALOS_TEMPLATE_NAME" {
  type        = string
  default     = "talos-template"
  description = "The name to associate with the Talos Template"
}
variable "TALOS_TEMPLATE_PATH" {
  type        = string
  default     = "/var/lib/vz/template/iso/talos-amd64.raw"
  description = "The filesystem path to store the Talos image"
}
variable "TALOS_TEMPLATE_VMID" {
  type        = string
  default     = null
  description = "The VM ID to associate with the Talos Template"
}


##################################################
#              Network Configuration             #
##################################################
variable "NET_IP_PREFIX" {
  type        = string
  description = "The first three octets of the IP Address associated with each VM. An initial fourth octet is configured for the Control Planes and Nodes."
}
variable "NET_GATEWAY" {
  type        = string
  description = "The network gateway that should be configured for the VMs."
}
variable "NET_NAMESERVER" {
  type        = string
  default     = "8.8.8.8"
  description = "The DNS server that should be configured for the K8S virtual machines."
}
variable "NET_SEARCH_DOMAIN" {
  type        = string
  default     = null
  description = "The DNS search domain that should be configured for the K8S virtual machines."
}
variable "NET_SUBNET_SIZE" {
  type        = string
  default     = 24
  description = "The subnet size expressed in bits for the VMs."
}
variable "NET_BRIDGE" {
  type        = string
  default     = "vmbr0"
  description = "The name of the network bridge used for the VMs."
}
variable "NET_TYPE" {
  type        = string
  default     = "virtio"
  description = "The type of virtual network card used for the VMs."
}
variable "NET_VLAN_ID" {
  type        = number
  default     = null
  description = "If configured, the VLAN ID that is associated with the network card for the VMs."
}


##################################################
#          Virtual Machine Configuration         #
##################################################
variable "VM_ENABLE_QEMU_GUEST_AGENT" {
  type        = number
  default     = 0
  description = "Whether the VMs should have the QEMU Guest Agent enabled."
}
variable "VM_RESOURCE_POOL" {
  type        = string
  default     = "Kubernetes"
  description = "If configured, the Resource Pool within which the VMs should be created."
}
variable "VM_START_ONBOOT" {
  type        = bool
  default     = false
  description = "Whether the VMs should automatically start on boot."
}
variable "VM_START_ONCREATE" {
  type        = bool
  default     = false
  description = "Whether the VMs should automatically start on boot."
}


##################################################
#              Storage Configuration             #
##################################################
variable "STR_SIZE" {
  type        = string
  default     = "20G"
  description = "The size, expressed in gigabytes, of the virtual hard disk that will be attached to the VMs."
}
variable "STR_CACHE_TYPE" {
  type        = string
  default     = null
  description = "If configured, the type of Disk Cache to use for the VMs."
}
variable "STR_ENABLE_BACKUPS" {
  type        = bool
  default     = false
  description = "Whether or not to enable backups for the VM."
}
variable "STR_IO_THREAD" {
  type        = number
  default     = 1
  description = "Whether to use IO Threads for each VM."
}
variable "STR_SCSI_HW" {
  type        = string
  default     = "virtio-scsi-single"
  description = "The type of virtual hard disk that will be attached to the VMs."
}
variable "STR_TYPE" {
  type        = string
  default     = "scsi"
  description = "The type of virtual hard disk that will be attached to the VMs."
}
variable "STR_ID" {
  type        = string
  description = "The name of the storage in Proxmox onto which the VMs should be deployed."
}


##################################################
#             Mayastor Configuration             #
##################################################
variable "MAYASTOR_ENABLE" {
  type        = bool
  default     = false
  description = "Whether to deploy additional disks, install iscsi extension, and include Rancher Mayastor."
}
variable "MAYASTOR_STR_TYPE" {
  type        = string
  default     = "scsi"
  description = "The type of virtual hard disk that will be attached to the VMs for Rancher Mayastor."
}
variable "MAYASTOR_STR_SIZE" {
  type        = string
  default     = "20G"
  description = "The size, expressed in gigabytes, of the virtual hard disk that will be attached to the VMs for Rancher Mayastor."
}
variable "MAYASTOR_STR_CACHE_TYPE" {
  type        = string
  default     = null
  description = "If configured, the type of Disk Cache to use for the Rancher Mayastor disk."
}
variable "MAYASTOR_STR_IO_THREAD" {
  type        = number
  default     = 1
  description = "Whether to use IO Threads for the Rancher Mayastor disk."
}
variable "MAYASTOR_ISCSI_TOOLS_VERSION" {
  type        = string
  default     = "v0.1.4"
  description = "The version of the ISCSI Tools Talos extension to include."
}
variable "MAYASTOR_STR_ID" {
  type        = string
  default     = null
  description = "The name of the storage in Proxmox that should be used for the Rancher Mayastor disk."
}
variable "MAYASTOR_VERSION" {
  type        = string
  default     = "2.0.1"
  description = "The version of Mayastor to install."
}


##################################################
#              Cilium Configuration              #
##################################################
variable "CILIUM_ENABLE" {
  type        = string
  default     = false
  description = "Whether Cilium should be installed instead of Flannel."
}
variable "CILIUM_VERSION" {
  type        = string
  default     = "v1.13.2"
  description = "The version of Cilium to install."
}


##################################################
#                Helm Configuration              #
##################################################
variable "HELM_VERSION" {
  type        = string
  default     = "v3.11.0"
  description = "The version of Helm to install when managing Addons."
}


##################################################
#            Kubernetes Configuration            #
##################################################
variable "K8S_CONFIG_SUFFIX" {
  type        = string
  description = "The unique suffix included for each Talos Machine Config. IT IS CRITICAL THAT THIS SHOULD NEVER CHANGE!"
}
variable "K8S_CLUSTER_NAME" {
  type        = string
  default     = "k8s-cluster"
  description = "The name of the Kubernetes Cluster."
}


##################################################
#     Kubernetes Control Plane Configuration     #
##################################################
variable "K8S_CP_CORES" {
  type        = number
  default     = 2
  description = "The number of CPU cores to add to each Control Plane VM."
}
variable "K8S_CP_HOSTNAME_PREFIX" {
  type        = string
  default     = "k8s-cp"
  description = "The prefix for the name and network hostname for each Control Plane VM. ('-#' is appended to each node)"
}
variable "K8S_CP_VIP_SUFFIX" {
  type        = number
  description = "The last octet that, when combined with `NET_IP_PREFIX`, is the IP Address of the Control Plane virtual shared IP Address."
}
variable "K8S_CP_IP_SUFFIX" {
  type        = string
  description = "The last octet that, when combined with `NET_IP_PREFIX`, is the IP Address of the first the Control Plane VM. Incremented by one for each additional VM."
}
variable "K8S_CP_MEMORY" {
  type        = number
  default     = 10240
  description = "The amount of memory, expressed in megabytes, to add to each Control Plane VM."
}
variable "K8S_CP_NUM" {
  type        = number
  default     = 3
  description = "The number of Kubernetes Control Plane VMs to deploy."
}
variable "K8S_CP_SOCKETS" {
  type        = number
  default     = 1
  description = "The number of CPU sockets to add to each Control Plane VM."
}
variable "K8S_CP_VMID" {
  type        = number
  default     = null
  description = "The VM ID to associate with the first Control Plane VM. Incremented by one for each node."
}

##################################################
#         Kubernetes Worker Configuration        #
##################################################
variable "K8S_WORKER_CORES" {
  type        = number
  default     = 4
  description = "The number of CPU cores to add to each node VM."
}
variable "K8S_WORKER_HOSTNAME_PREFIX" {
  type        = string
  default     = "k8s-node"
  description = "The prefix for the name and network hostname for each node VM. ('-#' is appended to each node)"
}
variable "K8S_WORKER_IP_SUFFIX" {
  type        = string
  description = "The last octet that, when combined with `NET_IP_PREFIX`, is the IP Address of the first node VM. Incremeneted by one for each additional VM."
}
variable "K8S_WORKER_MEMORY" {
  type        = number
  default     = 30720
  description = "The amount of memory, expressed in megabytes, to add to each node VM."
}
variable "K8S_WORKER_NUM" {
  type        = number
  default     = 3
  description = "The number of Kubernetes node VMs to deploy."
}
variable "K8S_WORKER_SOCKETS" {
  type        = number
  default     = 1
  description = "The number of CPU sockets to add to each node VM."
}
variable "K8S_WORKER_VMID" {
  type        = number
  description = "The VM ID to associate with the first node VM. Incremented by one for each node."
}
