variable "vm_instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}
variable "vm_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = true
}
variable "vm_root_volume_size" {
  type        = number
  description = "Root Volume size of the EC2 Instance"
}
variable "vm_root_volume_type" {
  type        = string
  description = "Root volume type of the EC2 Instance"
  default     = "gp3"
}