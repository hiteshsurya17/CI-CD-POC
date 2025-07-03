variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "my-eks-cluster"
}

variable "ecr_image_url" {
  description = "Full ECR image URL with tag"
  type        = string
}
