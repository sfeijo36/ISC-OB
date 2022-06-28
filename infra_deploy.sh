#!/bin/bash

cd /home/ec2-user/ISC-OB/deployment_infra
terraform init
terraform apply -auto-approve

aws eks --region us-east-1 update-kubeconfig --name Cluster-Boutique
cp /home/ec2-user/.kube/config /home/ec2-user/ISC-OB/deployment_servicios

cd /home/ec2-user/ISC-OB/deployment_servicios
terraform init
terraform apply -auto-approve

# Obtengo la url del loadbalancer
url=$(kubectl get all -n boutique | grep -o .*.us-east-1.elb.amazonaws.com | awk '{print $NF}')

# Instalacion del metrics server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Instalacion del horizontal autoscaler sobre el frontend
kubectl autoscale deployment frontend -n boutique --cpu-percent=30 --min=1 --max=10

# Genero tráfico sobre la página
# kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://$url; done"

