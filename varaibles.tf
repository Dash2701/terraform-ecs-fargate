variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type = string
}

variable "az_count" {
  type    = number
  default = 2
}

variable "health_check" {
  default = "/"
}
variable "default_tags" {
  type = map(any)
  default = {
    "company_name" : "xyz"
    "business_unit" : "IT"
    "support_email" : "abc@xyz.com"
  }
}


variable "key_name" {
  type    = string
  default = "lamp"
}


variable "multi_az_db" {
  type    = bool
  default = true
}


variable "replicas" {
  default = "1"
}

# The name of the container to run
variable "container_name" {
  default = "app"
}

# The minimum number of containers that should be running.
# Must be at least 1.
variable "ecs_autoscale_min_instances" {
  default = "1"
}

# The maximum number of containers that should be running.
variable "ecs_autoscale_max_instances" {
  default = "8"
}

#default Docker image Replace with your actual image
variable "default_backend_image" {
  default = "dash27/simple-devops-image"
}


#Container Port where application is exposed
variable "container_port" {
  default = "80"
}