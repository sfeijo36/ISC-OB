resource "kubernetes_manifest" "deployment_recommendationservice" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "default"
      "name" = "recommendationservice"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "recommendationservice"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "default"
          "labels" = {
            "app" = "recommendationservice"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "PORT"
                  "value" = "8080"
                },
                {
                  "name" = "PRODUCT_CATALOG_SERVICE_ADDR"
                  "value" = "productcatalogservice:3550"
                },
                {
                  "name" = "DISABLE_TRACING"
                  "value" = "1"
                },
                {
                  "name" = "DISABLE_PROFILER"
                  "value" = "1"
                },
                {
                  "name" = "DISABLE_DEBUGGER"
                  "value" = "1"
                },
              ]
              "image" = var.recommendationservice
              "livenessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:8080",
                  ]
                }
                "periodSeconds" = 5
              }
              "name" = "server"
              "ports" = [
                {
                  "containerPort" = 8080
                },
              ]
              "readinessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:8080",
                  ]
                }
                "periodSeconds" = 5
              }
              "resources" = {
                "limits" = {
                  "cpu" = "200m"
                  "memory" = "450Mi"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "220Mi"
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

resource "kubernetes_manifest" "service_recommendationservice" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "default"
      "name" = "recommendationservice"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "grpc"
          "port" = 8080
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "recommendationservice"
      }
      "type" = "ClusterIP"
    }
  }
}
