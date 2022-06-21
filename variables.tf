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