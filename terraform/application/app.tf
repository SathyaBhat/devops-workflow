data "aws_ami" "application_ami" {
  most_recent = true    
  filter {
    name   = "name"
    values = ["greatlearning-*"]
  }
  owners = ["self"]
}

data "aws_vpc" "GreatLearning" {
    filter {
        name = "tag:Name"
        values = ["GreatLearning"]
    }

}

data "aws_subnet" "ap-south-1a-public" {
    filter {
        name = "tag:Name"
        values = ["ap-south-1a-public"]
    }
}

data "aws_security_group" "sg-allow-all" {
    filter {
        name = "tag:Name"
        values = ["sg-allow-all"]
    }
}

resource "aws_key_pair" "ec2-key" {
    key_name ="greatlearning"
    public_key = "${file("~/.ssh/id_rsa_greatlearning.pub")}"
  
}

resource "aws_instance" "app" {
  ami           = "${data.aws_ami.application_ami.id}"
  instance_type = "t2.micro"
  subnet_id     = "${data.aws_subnet.ap-south-1a-public.id}"
  vpc_security_group_ids = ["${data.aws_security_group.sg-allow-all.id}"]
  key_name = "${aws_key_pair.ec2-key.id}"
  tags {
    Name      = "HelloWorld"
    CreatedOn = "${timestamp()}"
    vpc       = "${data.aws_vpc.GreatLearning.id}"
  }
}

output "address" {
  value = "${aws_instance.app.public_ip}"
}
