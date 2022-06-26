resource "kubernetes_manifest" "deployment_emailservice" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "boutique"
      "name" = "emailservice"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "emailservice"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "boutique"
          "labels" = {
            "app" = "emailservice"
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
                  "name" = "DISABLE_TRACING"
                  "value" = "1"
                },
                {
                  "name" = "DISABLE_PROFILER"
                  "value" = "1"
                },
              ]
              "image" = var.emailservice
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

resource "kubernetes_manifest" "service_emailservice" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "boutique"
      "name" = "emailservice"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "grpc"
          "port" = 5000
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "emailservice"
      }
      "type" = "ClusterIP"
    }
  }
}
