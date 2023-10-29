
variable "vpc_cidr" {
  default     = "177.70.0.0/24"
  type        = string
  description = "cidr blocks for vpc"
  sensitive   = true

}


variable "vpc_tenancy" {
  default   = "default"
  type      = string
  sensitive = true

}



variable "vpc_name" {
  default     = "dela_vpc"
  type        = string
  description = "name for vpc"
}





variable "public_subnet" {
  default     = "177.70.0.0/26"
  type        = string
  description = "public subnet1 cidr"
  sensitive   = true

}

variable "az1" {
  default = "us-east-1a"
  type    = string
}


variable "public_subnet_name" {
  default     = "pub_subnet"
  type        = string
  description = "name for public subnet"
}


variable "public_subnet2" {
  default     = "177.70.0.64/26"
  type        = string
  description = "public subnet2 cidr"
  sensitive   = true

}


variable "az2" {
  default = "us-east-1b"
  type    = string

}


variable "public_subnet2_name" {
  default     = "pub_subnet2"
  type        = string
  description = "name for public subnet2"
  sensitive   = true

}




variable "private_subnet" {
  default     = "177.70.0.128/26"
  type        = string
  description = "private subnet CIDR"
  sensitive   = true

}

variable "lb_out" {
  default   = ["177.70.0.128/26"]
  type      = list(string)
  sensitive = true
}

variable "default_route" {
  default   = ["0.0.0.0/0"]
  type      = list(string)
  sensitive = true
}

variable "az3" {
  default = "us-east-1c"
  type    = string

}

variable "private_subnet_name" {
  default     = "private_subnet"
  type        = string
  description = "name for private subnet"
  sensitive   = true
}



variable "gateway_name" {
  default     = "practice_gateway"
  type        = string
  description = "Name of the gateway"

}






variable "nat-gateway-name" {
  default = "practice-ngw"
  type    = string
}





variable "ngw_cidr" {
  default   = "0.0.0.0/0"
  type      = string
  sensitive = true
}



variable "practice_pub_rt_name" {
  default = "practice_pub_rt"
  type    = string
}




variable "ngw_cidr_v6" {
  default = "::/0"
  type    = string

}


variable "practice_private_rt_name" {
  default = "practice_private_rt"
  type    = string
}


variable "lb-name" {
  default     = "practice-lb"
  type        = string
  description = "lb name"
}

variable "lb_type" {
  default     = "application"
  type        = string
  description = "lb type"
}




variable "lb_sg_name" {
  default     = "practice_lb_sg"
  type        = string
  description = "lb sg name"
}




variable "web" {
  default     = 80
  type        = number
  description = "web traffic port"
}


variable "lb_protocol" {
  default = "tcp"
  type    = string

}



variable "web-group" {
  default = "practice-target-group"
  type    = string
}


variable "lb_listener_protocol" {
  default = "HTTP"
  type    = string
}



variable "lb_action" {
  default = "forward"
  type    = string
}


variable "target_id" {
}

variable "instance_sg_name" {
  default = "practice_instance_sg"
<<<<<<< HEAD
  type = string
}

variable "eg_protocol" {
  default = -1
  type = number
}

variable "all" {
  default = 0
  type = number 
}
=======
  type    = string
}
>>>>>>> 61555cc5d1cde23f9219205ed756b57d856111ad
