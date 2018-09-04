# aws/config/my_ami:ami-04681a1dbd79675a5
# aws/config/my_route53_zone_id:Z20NBA4QJSYPCC
# aws/config/my_ssh_key:amzn-detwa-east
# aws/config/my_subnet:subnet-3805d964

resource "consul_keys" "my_ami" {
  key {
    name    = "my_ami"
    path    = "aws/config/my_ami"
  }
}

resource "consul_keys" "my_route53_zone_id" {
  key {
    name    = "my_route53_zone_id"
    path    = "aws/config/my_route53_zone_id"
  }
}

resource "consul_keys" "my_ssh_key" {
  key {
    name    = "my_ssh_key"
    path    = "aws/config/my_ssh_key"
  }
}

resource "consul_keys" "my_subnet" {
  key {
    name    = "my_subnet"
    path    = "aws/config/my_subnet"
  }
}

###############################################################################
# Jenkins Instance
###############################################################################
resource "aws_instance" "jenkins" {
  ami = "${consul_keys.my_ami.var.my_ami}"
  subnet_id = "${consul_keys.my_subnet.var.my_subnet}"
  key_name = "${consul_keys.my_ssh_key.var.my_ssh_key}"
  # vpc_security_group_ids = ["${var.my_concourse_web_secgroups}"]
  instance_type = "t2.nano"
  disable_api_termination = true

  tags {
    Name = "jenkins"
  }

  provisioner "remote-exec" {
     inline = [
      "sudo yum -y install jenkins",
    ]

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = "${file("/Users/asalowi1/.ssh/amzn-detwa-east.pub")}"
    }
  }
}

resource "aws_route53_record" "jenkins" {
  zone_id = "${consul_keys.my_route53_zone_id.var.my_route53_zone_id}"
  name    = "jenkins.detwah.com"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.jenkins.public_ip}"]
}
