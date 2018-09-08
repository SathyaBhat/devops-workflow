// Create a VPC
resource "aws_vpc" "GreatLearning" {
    cidr_block = "10.0.0.0/25"
    enable_dns_hostnames = true

    tags {
        Name = "GreatLearning"
        environment = "dev"
    }
}

// Public subnets
resource "aws_subnet" "ap-south-1a-public" {
    vpc_id = "${aws_vpc.GreatLearning.id}"
    cidr_block = "10.0.0.0/27"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags {
        Name = "ap-south-1a-public"
        environment = "dev"
    }
}

resource "aws_subnet" "ap-south-1b-public" {
    vpc_id = "${aws_vpc.GreatLearning.id}"
    cidr_block = "10.0.0.32/27"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true
    tags {
        Name = "ap-south-1b-public"
        environment = "dev"
    }

}

// Private subnets
resource "aws_subnet" "ap-south-1a-private" {
    vpc_id = "${aws_vpc.GreatLearning.id}"
    cidr_block = "10.0.0.64/27"
    availability_zone = "ap-south-1a"
    tags {
        Name = "ap-south-1a-private"
        environment = "dev"
    }
}

resource "aws_subnet" "ap-south-1b-private" {
    vpc_id = "${aws_vpc.GreatLearning.id}"
    cidr_block = "10.0.0.96/27"
    availability_zone = "ap-south-1b"
    tags {
        Name = "ap-south-1b-private"
        environment = "dev"
    }
}

// Internet gateway, for Public subnet
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.GreatLearning.id}"
    tags {
        Name = "igw"
        environment = "dev"
    }
  
}

// EIP for NAT Gateway
resource "aws_eip" "natgw-eip" {
    vpc = true
    tags {
        Name = "natgw-eip"
        environment = "dev"
    }
}

// NAT Gateway, for private subnets

resource "aws_nat_gateway" "natgw-ap-south-1a-public" {
    allocation_id = "${aws_eip.natgw-eip.id}"
    subnet_id = "${aws_subnet.ap-south-1a-public.id}"
    tags {
        Name = "natgw-ap-south-1a-public"
        environment = "dev"
    }
}
// Route table, for public subnet
resource "aws_route_table" "rt-public" {
    vpc_id = "${aws_vpc.GreatLearning.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags {
        Name = "rt-public"
        environment = "dev"
    }
  
}

// Route table for private subnet
resource "aws_route_table" "rt-ap-south-1a-private" {
    vpc_id = "${aws_vpc.GreatLearning.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.natgw-ap-south-1a-public.id}"
    }
    tags {
        Name = "rt-ap-south-1a-private"
        environment = "dev"
    }
}

// Route table association for public subnet 
resource "aws_route_table_association" "rta-ap-south-1a-public" {
    subnet_id = "${aws_subnet.ap-south-1a-public.id}"
    route_table_id = "${aws_route_table.rt-public.id}"
  
}

resource "aws_route_table_association" "rta-ap-south-1b-public" {
    subnet_id = "${aws_subnet.ap-south-1b-public.id}"
    route_table_id = "${aws_route_table.rt-public.id}"
}   


// Route table for private subnet association
