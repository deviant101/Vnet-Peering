variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the virtual network is created"
}

variable "username" {
  type        = string
  description = "The username for the virtual machine"
  default     = "Admin"
}

variable "password" {
  type        = string
  description = "The password for the virtual machine"
  default     = "admin@12345"
}

variable "location" {
  type        = string
  description = "The location/region where the virtual network is created"
  default     = "East US"
}

variable "hostname" {
  type        = string
  description = "The hostname of the virtual machine"
}