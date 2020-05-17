variable "region" {
  type = string
  default = "eu-west-2"
}

variable "account_id" {
  type = string
}

variable "domain" {
  type = string
  default = "hollygram.co.uk"
}

variable "state_bucket" {
  type = string
  default = "terraform_state"
}
