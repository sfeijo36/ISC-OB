resource "kubernetes_manifest" "deployment_productcatalogservice" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "productcatalogservice"
      "namespace" = "boutique"

    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "productcatalogservice"
        }
      }
      "template" = {
        "metadata" = {
            "namespace" = "boutique"
          "labels" = {
            "app" = "productcatalogservice"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "PORT"
                  "value" = "3550"
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
              "image" = var.productcatalogservice
              "livenessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:3550",
                  ]
                }
              }
              "name" = "server"
              "ports" = [
                {
                  "containerPort" = 3550
                },
              ]
              "readinessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:3550",
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
          "terminationGracePeriodSeconds" = 5
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_productcatalogservice" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = "productcatalogservice"
      "namespace" = "boutique"

    }
    "spec" = {
      "ports" = [
        {
          "name" = "grpc"
          "port" = 3550
          "targetPort" = 3550
        },
      ]
      "selector" = {
        "app" = "productcatalogservice"
      }
      "type" = "ClusterIP"
    }
  }
}
