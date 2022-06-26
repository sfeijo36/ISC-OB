provider "kubernetes" {
  config_path    = "./config"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "boutique"
  }
}
