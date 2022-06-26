resource "aws_eks_cluster" "Cluster-Boutique" {
  name            = "Cluster-Boutique"
  role_arn        = var.LabRole

  vpc_config {
    security_group_ids = [aws_security_group.security-group.id]
    subnet_ids     = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
  }
}

resource "aws_eks_node_group" "node-ec2" {
  cluster_name    = aws_eks_cluster.Cluster-Boutique.name
  node_group_name = "t3_micro-node_group"
  node_role_arn   = var.LabRole
  subnet_ids      = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  ami_type       = var.ami
  instance_types = ["t3.large"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20
}
