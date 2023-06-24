
variable "size_instance" {
  type = string
  default = "t2.micro"
  description = "This is instance size"
}

variable "ami_ubuntu" {
  type = string
  default = "ami-0d52744d6551d851e"
  description = "This is ami for ubuntu instance"
}

variable "key-name" {
  type        = string
  default     = "game-cd.pem"
  description = "This is the key pair name for SSH access"
}