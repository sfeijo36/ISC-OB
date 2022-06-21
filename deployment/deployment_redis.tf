resource "kubernetes_manifest" "deployment_redis_cart" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "default"
      "name" = "redis-cart"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "redis-cart"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "default"
          "labels" = {
            "app" = "redis-cart"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "redis:alpine"
              "livenessProbe" = {
                "periodSeconds" = 5
                "tcpSocket" = {
                  "port" = 6379
                }
              }
              "name" = "redis"
              "ports" = [
                {
                  "containerPort" = 6379
                },
              ]
              "readinessProbe" = {
                "periodSeconds" = 5
                "tcpSocket" = {
                  "port" = 6379
                }
              }
              "resources" = {
                "limits" = {
                  "cpu" = "125m"
                  "memory" = "256Mi"
                }
                "requests" = {
                  "cpu" = "70m"
                  "memory" = "200Mi"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/data"
                  "name" = "redis-data"
                },
              ]
            },
          ]
          "volumes" = [
            {
              "emptyDir" = {}
              "name" = "redis-data"
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_redis_cart" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "default"
      "name" = "redis-cart"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "redis"
          "port" = 6379
          "targetPort" = 6379
        },
      ]
      "selector" = {
        "app" = "redis-cart"
      }
      "type" = "ClusterIP"
    }
  }
}
