provider "vault" {
  address = "https://vault.example.com"
  token   = var.vault_token
}

data "vault_kv_secret_v2" "flask_app_secrets" {
  mount = "secret"
  name  = "flask-app"
}

provider "aws" {
  region     = var.aws_region
  access_key = data.vault_kv_secret_v2.flask_app_secrets.data["aws_access_key"]
  secret_key = data.vault_kv_secret_v2.flask_app_secrets.data["aws_secret_key"]
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}
