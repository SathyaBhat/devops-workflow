
resource "aws_security_group" "sg-all" {
    name = "SG to allow all traffic"
    vpc_id = "${aws_vpc.GreatLearning.id}"

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "sg-allow-all"
        environment = "dev"
    }
}
