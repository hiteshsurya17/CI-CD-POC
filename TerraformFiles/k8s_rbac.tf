resource "kubernetes_service_account" "flask_app_sa" {
  metadata {
    name      = "flask-app-sa"
    namespace = "default"
    annotations = {
      "vault.hashicorp.com/agent-inject"           = "true"
      "vault.hashicorp.com/role"                   = "flask-app-role"
      "vault.hashicorp.com/agent-inject-secret-db" = "secret/data/flask-app"
    }
  }
}

resource "kubernetes_role" "flask_app_secret_reader" {
  metadata {
    name      = "flask-app-secret-role"
    namespace = "default"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get"]
    resource_names = [
      "vault-token-flask-app"  # The name of the secret it’s allowed to access
    ]
  }
}

resource "kubernetes_role_binding" "flask_app_secret_binding" {
  metadata {
    name      = "flask-app-secret-binding"
    namespace = "default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.flask_app_secret_reader.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.flask_app_sa.metadata[0].name
    namespace = "default"
  }
}
