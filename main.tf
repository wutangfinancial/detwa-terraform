resource "aws_instance" "jenkins" {
  ami = "${var.my_ami}"
  subnet_id = "${var.my_subnet}"
  key_name = "${var.my_key}"
  vpc_security_group_ids = ["${var.my_jenkins_secgroups}"]
  instance_type = "t2.nano"
  disable_api_termination = true
  
  tags {
    Name = "jenkins"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.jenkins.public_ip} > ip_address.txt"
  }
}
