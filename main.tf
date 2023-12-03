
# Create an VPC-1

resource "aws_vpc" "vpc-1" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
}


# Create an VPC-1

resource "aws_vpc" "vpc-2" {
    cidr_block = "12.0.0.0/16"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
}

# Create an Subnets for both Vpc-1 and Vpc-2

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.vpc-1.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = "true"
    
    tags = {
        Name = "subnet-1"
    }
}

resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.vpc-2.id
    cidr_block = "12.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = "true"
    
    tags = {
        Name = "subnet-2"
    }
}

# Create an Internet Gateway for Vpc-1 and Vpc-2

resource "aws_internet_gateway" "IGW-1" {
    vpc_id = aws_vpc.vpc-1.id
}

resource "aws_internet_gateway" "IGW-2" {
    vpc_id = aws_vpc.vpc-2.id
}


# Create a Route Table for Vpc-1 and Vpc-2
resource "aws_route_table" "Rt-vpc-1" {
    
    vpc_id = aws_vpc.vpc-1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW-1.id
    }

}

resource "aws_route_table" "Rt-vpc-2" {
    
    vpc_id = aws_vpc.vpc-2.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW-2.id
    }

}

# Create a Route Table for Vpc-1 and Vpc-2
resource "aws_route_table_association" "Rta-1" {
    subnet_id      = aws_subnet.subnet-1.id
    route_table_id = aws_route_table.Rt-vpc-1.id
}

resource "aws_route_table_association" "Rta-2" {
    subnet_id      = aws_subnet.subnet-2.id
    route_table_id = aws_route_table.Rt-vpc-2.id
}

# Create an Security Group for both the Vpc's

resource "aws_security_group" "Sg-1" {
    name        = "SG-1"
    description = "Allow TLS inbound traffic"
    vpc_id      = aws_vpc.vpc-1.id

    ingress {
        description      = "TLS from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
        description      = "HTTP"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "SG-1"
    }
}

# For VPC-2

resource "aws_security_group" "Sg-2" {
    name        = "SG-2"
    description = "Allow TLS inbound traffic"
    vpc_id      = aws_vpc.vpc-2.id

    ingress {
        description      = "TLS from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
        description      = "HTTP"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }


    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "SG-2"
    }
}

# Create an EC2 Instance for both the Vpc and Subnets

resource "aws_instance" "Ec2-1" {
    ami = "ami-0287a05f0ef0e9d9a"
    instance_type = "t2.micro"
    key_name = "Minikube_Ravi"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [aws_security_group.Sg-1.id]
    subnet_id = aws_subnet.subnet-1.id
    user_data = file("apache.sh")

    tags = {
        Name = "Ec-1"
    }
}

resource "aws_instance" "Ec2-2" {
    ami = "ami-0287a05f0ef0e9d9a"
    instance_type = "t2.micro"
    key_name = "Minikube_Ravi"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [aws_security_group.Sg-2.id]
    subnet_id = aws_subnet.subnet-2.id
    user_data = file("apache.sh")

    tags = {
        Name = "Ec-2"
    }

}
