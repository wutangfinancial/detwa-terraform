resource "aws_instance" "pipeline" {
  ami = "${var.my_ami}"
  subnet_id = "${var.my_subnet}"
  key_name = "${var.my_key}"
  vpc_security_group_ids = ["${var.my_pipeline_secgroups}"]
  instance_type = "t2.nano"
  disable_api_termination = true
  
  tags {
    Name = "pipeline"
  }

  provisioner "local-exec" {
    command = "curl https://raw.githubusercontent.com/wutangfinancial/my_hab_bootstrap/master/bootstrap.sh | sudo bash"
  }
}

resource "aws_route53_record" "pipeline" {
  zone_id = "${var.my_route53_zone_id}"
  name    = "pipeline.detwah.com"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.pipeline.public_ip}"]
}
