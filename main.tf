resource "aws_instance" "concourse" {
  ami = "${var.my_ami}"
  subnet_id = "${var.my_subnet}"
  key_name = "${var.my_key}"
  vpc_security_group_ids = ["${var.my_concourse_secgroups}"]
  instance_type = "t2.nano"
  disable_api_termination = true
  
  tags {
    Name = "concourse"
  }

  provisioner "remote-exec" {
    inline = [
      "curl https://raw.githubusercontent.com/wutangfinancial/my_hab_bootstrap/master/bootstrap.sh | sudo bash",
      "sudo hab svc status",
    ]
  }
}

resource "aws_route53_record" "concourse" {
  zone_id = "${var.my_route53_zone_id}"
  name    = "concourse.detwah.com"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.concourse.public_ip}"]
}
