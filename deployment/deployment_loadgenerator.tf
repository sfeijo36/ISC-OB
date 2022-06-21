resource "kubernetes_manifest" "deployment_loadgenerator" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "default"
      "name" = "loadgenerator"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "loadgenerator"
        }
      }
      "template" = {
        "metadata" = {
          "namespace" = "default"
          "annotations" = {
            "sidecar.istio.io/rewriteAppHTTPProbers" = "true"
          }
          "labels" = {
            "app" = "loadgenerator"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "FRONTEND_ADDR"
                  "value" = "ad7411b377f7b46218d8abdfbabf138e-848033278.us-east-1.elb.amazonaws.com:80"
                },
                {
                  "name" = "USERS"
                  "value" = "10"
                },
              ]
              "image" = var.loadgenerator
              "name" = "main"
              "resources" = {
                "limits" = {
                  "cpu" = "500m"
                  "memory" = "512Mi"
                }
                "requests" = {
                  "cpu" = "300m"
                  "memory" = "256Mi"
                }
              }
            },
          ]
          "initContainers" = [
            {
              "command" = [
                "/bin/sh",
                "-exec",
                 <<EOT
                 echo "Init container pinging frontend: $${FRONTEND_ADDR}..."
                 STATUSCODE=$(wget --server-response http://$${FRONTEND_ADDR} 2>&1 | awk '/^  HTTP/{print $2}')
                 if test $STATUSCODE -ne 200; then
                     echo "Error: Could not reach frontend - Status code: $${STATUSCODE}"
                     exit 1
                 fi
                 EOT
              ]
              "env" = [
                {
                  "name" = "FRONTEND_ADDR"
                  "value" = "ad7411b377f7b46218d8abdfbabf138e-848033278.us-east-1.elb.amazonaws.com"
                },
              ]
              "image" = "busybox:latest"
              "name" = "frontend-check"
            },
          ]
          "restartPolicy" = "Always"
          "serviceAccountName" = "default"
          "terminationGracePeriodSeconds" = 5
        }
      }
    }
  }
}
