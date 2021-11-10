provider "aws"{
    region = "us-east-1"
}

data "aws_ami" "IAC_ami"{
    most_recent = true
    owners = ["aws-marketplace"]

    filter{
        name = "name"
        values = ["*IAC*"]
    }
}

resource "aws_security_group" "IAC_allow_htp_ssh" {
  name        = "IAC_allow_htp_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress{
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

   ingress{
      from_port        = 22
      to_port          = 22
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "web" {
    ami = "${data.aws_ami_openshot_ami.id}"
    instance_type ="c5.xlarge"
    security_groups=["{aws_security group.IAC_allow_http_ssh.name}"]
    key_name = "IAC-ssh"
    user_data = "${file{"./openshot.sh"}}"
}

tags = {
    Name = "helloWorldProgram"
}

output "IP" {
  value = "${aws_instance.web.public_ip}"
}