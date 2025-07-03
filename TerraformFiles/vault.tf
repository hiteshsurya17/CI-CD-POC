provider "vault" {
  address = "https://vault.mycompany.com:8200"
  token   = var.vault_token
}

resource "vault_kv_secret_v2" "flask_app_secrets" {
  mount = "secret"
  name  = "flask-app"

  data_json = jsonencode({
    db_password     = "supersecret-db-pass"
    api_key         = "abcd1234-api-key"
    aws_access_key  = "AKIAEXAMPLE123456789"
    aws_secret_key  = "supersecretawskey987654321"
  })
}
