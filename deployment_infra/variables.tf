variable "region" {
    default = "us-east-1"
}

variable "LabRole" {
    default = "arn:aws:iam::257128885671:role/LabRole"
}

variable "ami" {
    default = "AL2_x86_64"
}

variable "instance_types" {
    default = "t3.large"
}

variable "cidr_block" {
    default = "172.16.0.0/16"
}

variable "cidr_blocks" {
    default = ["0.0.0.0/0"]
}

variable "cidr_blocks_rt" {
    default = "0.0.0.0/0"
}

variable "cidr_subnet1" {
    default =  "172.16.1.0/24"
}

variable "cidr_subnet2" {
    default =  "172.16.2.0/24"

}



variable "azA" {
    default = "us-east-1a"
}

variable "azB" {
    default = "us-east-1b"
}


