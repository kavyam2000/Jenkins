
resource "aws_instance" "ProjectSpecServers" {
  ami = "${lookup(var.amiid, var.region)}"
  instance_type = "t2.micro"
  count = "${var.instance_count}"
  vpc_security_group_ids = "sg-09ba62e97131ec79f"
  tags = {
    Name = "Project Specification"
  }

  key_name = "${var.key_name}"

user_data = "${file("user-data.txt")}"
}

#output "public_ip" {
 #   value = "${formatlist("%v", aws_instance.JenkinsServers.*.public_ip)}"
#}
