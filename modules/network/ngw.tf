resource "aws_eip" "eks_ngw_eip_1a" {
  vpc = true
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eip-1a",

    }

  )
}


resource "aws_eip" "eks_ngw_eip_1b" {
  vpc = true
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eip-1b",

    }

  )
}

resource "aws_nat_gateway" "eks-ngw-1a" {
  allocation_id = aws_eip.eks_ngw_eip_1a.id
  subnet_id     = aws_subnet.eks_public_1a.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ngw-1a",

    }

  )
}

resource "aws_nat_gateway" "eks-ngw-1b" {
  allocation_id = aws_eip.eks_ngw_eip_1b.id
  subnet_id     = aws_subnet.eks_public_1b.id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ngw-1b",

    }

  )
}



resource "aws_route_table" "eks_private_table-1a" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-ngw-1a.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-priv-routetable-1a"
    }
  )


}


resource "aws_route_table" "eks_private_table-1b" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-ngw-1b.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-priv-routetable-1b"
    }
  )

}