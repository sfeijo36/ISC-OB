resource "kubernetes_manifest" "deployment_cartservice" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "default"
      "name" = "cartservice"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "cartservice"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "default"
          "labels" = {
            "app" = "cartservice"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "REDIS_ADDR"
                  "value" = "redis-cart:6379"
                },
              ]
              "image" = var.cartservice
              "livenessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:7070",
                    "-rpc-timeout=5s",
                  ]
                }
                "initialDelaySeconds" = 15
                "periodSeconds" = 10
              }
              "name" = "server"
              "ports" = [
                {
                  "containerPort" = 7070
                },
              ]
              "readinessProbe" = {
                "exec" = {
                  "command" = [
                    "/bin/grpc_health_probe",
                    "-addr=:7070",
                    "-rpc-timeout=5s",
                  ]
                }
                "initialDelaySeconds" = 15
              }
              "resources" = {
                "limits" = {
                  "cpu" = "300m"
                  "memory" = "128Mi"
                }
                "requests" = {
                  "cpu" = "200m"
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

resource "kubernetes_manifest" "service_cartservice" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "default"
      "name" = "cartservice"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "grpc"
          "port" = 7070
          "targetPort" = 7070
        },
      ]
      "selector" = {
        "app" = "cartservice"
      }
      "type" = "ClusterIP"
    }
  }
}
