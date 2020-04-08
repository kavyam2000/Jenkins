provider "aws" {
   region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "firstbucket-kk"
    key    = "jenkinsps/terraform.tfstate"
    region = "us-east-2"
  }
}
resource "aws_instance" "ProjectspecServers" {
  ami = "${lookup(var.amiid, var.region)}"
  instance_type = "t2.micro"
  count = "${var.instance_count}"
  vpc_security_group_ids = ["${var.security_group}"]
  tags = {
    Name = "Project Specifications"
  }

  key_name = "${var.key_name}"

user_data = "${file("user-data.txt")}"
}

output "public_ip" {
    value = "${formatlist("%v", aws_instance.ProjectspecServers.*.public_ip)}"
}
