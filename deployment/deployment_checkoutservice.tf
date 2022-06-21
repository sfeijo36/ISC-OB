resource "kubernetes_manifest" "deployment_checkoutservice" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "default"
      "name" = "checkoutservice"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "checkoutservice"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "default"
          "labels" = {
            "app" = "checkoutservice"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "PORT"
                  "value" = "5050"
                },
                {
                  "name" = "PRODUCT_CATALOG_SERVICE_ADDR"
                  "value" = "productcatalogservice:3550"
                },
                {
                  "name" = "SHIPPING_SERVICE_ADDR"
                  "value" = "shippingservice:50051"
                },
                {
                  "name" = "PAYMENT_SERVICE_ADDR"
                  "value" = "paymentservice:50051"
                },
                {
                  "name" = "EMAIL_SERVICE_ADDR"
                  "value" = "emailservice:5000"
                },
                {
                  "name" = "CURRENCY_SERVICE_ADDR"
                  "value" = "currencyservice:7000"
                },
                {
                  "name" = "CART_SERVICE_ADDR"
                  "value" = "cartservice:7070"
                },
                {
                  "name" = "DISABLE_STATS"
                  "value" = "1"
                },
                {
                  "name" = "DISABLE_TRACING"
                  "value" = "1"
                },
                {
                  "name" = "DISABLE_PROFILER"
                  "value" = "1"
                },
              ]
              "image" = var.checkoutservice
              "livenessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:5050",
                  ]
                }
              }
              "name" = "server"
              "ports" = [
                {
                  "containerPort" = 5050
                },
              ]
              "readinessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:5050",
                  ]
                }
              }
              "resources" = {
                "limits" = {
                  "cpu" = "200m"
                  "memory" = "128Mi"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "64Mi"
                }
              }
            },
          ]
          "serviceAccountName" = "default"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_checkoutservice" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "default"
      "name" = "checkoutservice"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "grpc"
          "port" = 5050
          "targetPort" = 5050
        },
      ]
      "selector" = {
        "app" = "checkoutservice"
      }
      "type" = "ClusterIP"
    }
  }
}
