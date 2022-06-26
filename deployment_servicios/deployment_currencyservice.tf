resource "kubernetes_manifest" "deployment_currencyservice" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "boutique"
      "name" = "currencyservice"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "currencyservice"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "boutique"
          "labels" = {
            "app" = "currencyservice"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "PORT"
                  "value" = "7000"
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
              "image" = var.currencyservice
              "livenessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:7000",
                  ]
                }
              }
              "name" = "server"
              "ports" = [
                {
                  "containerPort" = 7000
                  "name" = "grpc"
                },
              ]
              "readinessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:7000",
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

resource "kubernetes_manifest" "service_currencyservice" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "boutique"
      "name" = "currencyservice"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "grpc"
          "port" = 7000
          "targetPort" = 7000
        },
      ]
      "selector" = {
        "app" = "currencyservice"
      }
      "type" = "ClusterIP"
    }
  }
}
