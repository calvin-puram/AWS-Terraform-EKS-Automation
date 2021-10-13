

provider "kubernetes" {
  
  host = data.aws_eks_cluster.myapp_cluster.endpoint
  token = data.aws_eks_cluster_auth.myapp_cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.myapp_cluster.certificate_authority.0.data)
}

data "aws_eks_cluster" "myapp_cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "myapp_cluster" {
  name = module.eks.cluster_id
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.20.0"
  
  cluster_name = "myapp-cluster"
  cluster_version = "1.17"

  subnets = module.myapp-vpc.private_subnets
  vpc_id = module.myapp-vpc.vpc_id

  tags = {
      environment = "development"
      application = "myapp"
  }

  worker_groups = [
      {
          instance_type = "t2.small"
          name = "worker-group-1"
          asg_desired_capacity = 2

      },

      {
          instance_type = "t2.medium"
          name = "worker-group-2"
          asg_desired_capacity = 1

      },
  ]
}