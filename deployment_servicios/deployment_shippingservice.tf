resource "kubernetes_manifest" "deployment_shippingservice" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "boutique"
      "name" = "shippingservice"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "shippingservice"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "boutique"
          "labels" = {
            "app" = "shippingservice"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "PORT"
                  "value" = "50051"
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
              "image" = var.shippingservice
              "livenessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:50051",
                  ]
                }
              }
              "name" = "server"
              "ports" = [
                {
                  "containerPort" = 50051
                },
              ]
              "readinessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:50051",
                  ]
                }
                "periodSeconds" = 5
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

resource "kubernetes_manifest" "service_shippingservice" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "boutique"
      "name" = "shippingservice"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "grpc"
          "port" = 50051
          "targetPort" = 50051
        },
      ]
      "selector" = {
        "app" = "shippingservice"
      }
      "type" = "ClusterIP"
    }
  }
}
