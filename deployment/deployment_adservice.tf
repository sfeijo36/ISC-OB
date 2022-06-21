resource "kubernetes_manifest" "deployment_adservice" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "adservice"
      "namespace" = "default"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "adservice"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "default"
          "labels" = {
            "app" = "adservice"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "PORT"
                  "value" = "9555"
                },
                {
                  "name" = "DISABLE_STATS"
                  "value" = "1"
                },
                {
                  "name" = "DISABLE_TRACING"
                  "value" = "1"
                },
              ]
              "image" = var.adservice
              "livenessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:9555",
                  ]
                }
                "initialDelaySeconds" = 20
                "periodSeconds" = 15
              }
              "name" = "server"
              "ports" = [
                {
                  "containerPort" = 9555
                },
              ]
              "readinessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:9555",
                  ]
                }
                "initialDelaySeconds" = 20
                "periodSeconds" = 15
              }
              "resources" = {
                "limits" = {
                  "cpu" = "300m"
                  "memory" = "300Mi"
                }
                "requests" = {
                  "cpu" = "200m"
                  "memory" = "180Mi"
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

resource "kubernetes_manifest" "service_adservice" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "default"
      "name" = "adservice"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "grpc"
          "port" = 9555
          "targetPort" = 9555
        },
      ]
      "selector" = {
        "app" = "adservice"
      }
      "type" = "ClusterIP"
    }
  }
}
