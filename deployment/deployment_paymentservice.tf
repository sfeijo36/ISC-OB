resource "kubernetes_manifest" "deployment_paymentservice" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "boutique"
      "name" = "paymentservice"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "paymentservice"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "boutique"
          "labels" = {
            "app" = "paymentservice"
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
              "image" = var.paymentservice
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

resource "kubernetes_manifest" "service_paymentservice" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "boutique"
      "name" = "paymentservice"
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
        "app" = "paymentservice"
      }
      "type" = "ClusterIP"
    }
  }
}
