provider "aws" {
   region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "firstbucket-kk"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-2"
  }
}

resource aws_security_group "Jen_Security" {
  name = "Jenkins-security-group"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "Jenkins-security-group"
  }
}
resource "aws_instance" "JenkinsServers" {
  ami = "${lookup(var.amiid, var.region)}"
  instance_type = "t2.micro"
  count = "${var.instance_count}"
  vpc_security_group_ids = [aws_security_group.Jen_Security.id]
  tags = {
    Name = "Jenkins-terraformInst"
  }

  key_name = "${var.key_name}"

user_data = "${file("user-data.txt")}"
}

output "public_ip" {
    value = "${formatlist("%v", aws_instance.JenkinsServers.*.public_ip)}"
}
