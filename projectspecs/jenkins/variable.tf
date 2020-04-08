variable "region" {
  default = "us-east-2"
}
variable "amiid" {
  type = "map"
  default = {
    us-east-2 = "ami-0fc20dd1da406780b"
    us-east-1 = "ami-07ebfd5b3428b6f4d"
  }
  description = "You may added more regions if you want"
}

variable "instance_count" {
  default = "1"
}
variable "key_name" {
  default = "kk_awskey"
  description = "the ssh key to used for the EC2 instance"
}

variable "vpc_id" {
  default = "vpc-d6529abd"
  description = "VPC ID"
}
variable "security_group" {
   default = "sg-0815fe0c66a93f578"
  }
