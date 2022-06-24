#AWS VPC CONFIGURATION

resource "aws_vpc" "Kemba" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Kemba"
  }
}


#AWS PRIVATE SUBNET CONFIG

resource "aws_subnet" "Private-subnet" {
  vpc_id     = aws_vpc.Kemba.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Private-subnet"
  }
}



#AWS PRIVATE SUBNET TWO CONFIG

resource "aws_subnet" "Private-subnet-2" {
  vpc_id     = aws_vpc.Kemba.id
  cidr_block = "10.0.51.0/24"

  tags = {
    Name = "Private-subnet-2"
  }
}



#AWS PUBLIC SUBNET CONFIG

resource "aws_subnet" "Public-subnet" {
  vpc_id     = aws_vpc.Kemba.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Public-subnet"
  }
}

#AWS PUBLIC SUBNET TWO CONFIG

resource "aws_subnet" "Public-subnet-two" {
  vpc_id     = aws_vpc.Kemba.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Public-subnet-two"
  }
}


#AWS ROUTE TABLE ONE CONFIG

resource "aws_route_table" "Route-table-one" {
  vpc_id = aws_vpc.Kemba.id

  route = []

  tags = {
    Name = "Route-table-one"
  }
}


#AWS ROUTE TABLE TWO CONFIG

resource "aws_route_table" "Route-table-two" {
  vpc_id = aws_vpc.Kemba.id

  route = []

  tags = {
    Name = "Route-table-two"
  }
}


#AWS ROUTE TABLE ASSOCIATION

resource "aws_route_table_association" "Routy-one" {
  subnet_id      = aws_subnet.Private-subnet.id
  route_table_id = aws_route_table.Route-table-one.id
}


#AWS ROUTE TABLE 2 ASSOCIATION

resource "aws_route_table_association" "Routy-two" {
  subnet_id      = aws_subnet.Private-subnet-2.id
  route_table_id = aws_route_table.Route-table-one.id
}


#AWS ROUTE TABLE 3 ASSOCIATION

resource "aws_route_table_association" "Routy-three" {
  subnet_id      = aws_subnet.Public-subnet.id
  route_table_id = aws_route_table.Route-table-two.id
}


#AWS ROUTE TABLE 4 ASSOCIATION

resource "aws_route_table_association" "Routy-four" {
  subnet_id      = aws_subnet.Public-subnet-two.id
  route_table_id = aws_route_table.Route-table-two.id
}


#AWS INTERNET GATEWAY CONFIG

resource "aws_internet_gateway" "Psiphon" {
  vpc_id = aws_vpc.Kemba.id

  tags = {
    Name = "Psiphon"
  }
}


#AWS ROUTE CONFIG

resource "aws_route" "channel" {
  route_table_id            = aws_route_table.Route-table-two.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.Psiphon.id
}
