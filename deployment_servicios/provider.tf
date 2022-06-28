provider "kubernetes" {
  config_path    = "./config"
}

resource "kubernetes_namespace" "boutique" {
  metadata {
    name = "boutique"
  }
}
