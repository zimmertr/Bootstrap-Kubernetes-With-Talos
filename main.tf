terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.14"
    }
  } 
}

provider "proxmox" {
  pm_parallel     = var.PROXMOX_NUM_PROCESSES
  pm_tls_insecure = var.PROXMOX_ALLOW_INSECURE
  pm_timeout      = var.PROXMOX_API_TIMEOUT
}
