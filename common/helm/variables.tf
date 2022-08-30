variable "release_name" {
  type = string
}

variable "chart_name" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "namespace" {
  type = string
}

variable "values" {
  type = string 
  default = ""
}

variable "repository" {
  type = string
  default = ""
}

variable "timeout" {
  type = integer
  default = 300
}

variable "cleanup_on_fail" {
  type = boolean
  default = true
}

variable "wait" {
  type = boolean
  default = true
}

variable "wait_for_jobs" {
  type = boolean
  default = true
}