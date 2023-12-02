# Create a Vpc Peering Connection Between 2 Vpc's

# From Vpc-1 to Vpc-2
resource "aws_vpc_peering_connection" "peer-1" {
    vpc_id        = aws_vpc.vpc-1.id
    peer_vpc_id   = aws_vpc.vpc-2.id
    auto_accept   = true

    accepter {
        allow_remote_vpc_dns_resolution = true
    } 
}

resource "aws_route" "route-1" {
    route_table_id         = aws_route_table.Rt-vpc-1.id
    destination_cidr_block = aws_vpc.vpc-2.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peer-1.id
}

# From Vpc-2 to Vpc-1

resource "aws_route" "route-2" {
    route_table_id         = aws_route_table.Rt-vpc-2.id
    destination_cidr_block = aws_vpc.vpc-1.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peer-1.id
}
