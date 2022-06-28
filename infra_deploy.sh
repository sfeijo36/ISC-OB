#!/bin/bash

# Realizo el deploy de la infraestructura necesaria.
cd /home/ec2-user/ISC-OB/deployment_infra
terraform init
terraform apply -auto-approve

# Actuliazo y copio el archivo de config de kube.
aws eks --region us-east-1 update-kubeconfig --name Cluster-Boutique     
cp /home/ec2-user/.kube/config /home/ec2-user/ISC-OB/deployment_servicios

# Build y tag de docker + push hacia ECR

# Guardo como variable, los output del ecr.tf.
adservice=$(terraform output -raw adservice)
cartservice=$(terraform output -raw cartservice)
checkoutservice=$=$(terraform output -raw checkoutservice)
currencyservice=$(terraform output -raw currencyservice)
emailservice=$(terraform output -raw emailservice)
frontend=$(terraform output -raw frontend)
loadgenerator=$(terraform output -raw loadgenerator)
paymentservice=$(terraform output -raw paymentservice)
shippingservice=$(terraform output -raw shippingservice)
productcatalogservice=$(terraform output -raw productcatalogservice)
recommendationservice=$(terraform output -raw recommendationservice)

# Actualizo el tag de las imagenes, con los parametros obtenidos en la creacion de las imágenes en ECR para luego pushearlas.
sudo su - root -c "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 257128885671.dkr.ecr.us-east-1.amazonaws.com"
sudo su - root -c "docker tag adservice:latest $adservice:latest"
sudo su - root -c "docker push $adservice:latest"

sudo su - root -c "docker tag adservice:latest $cartservice:latest"
sudo su - root -c "docker push $cartservice:latest"

sudo su - root -c "docker tag adservice:latest $checkoutservice:latest"
sudo su - root -c "docker push $checkoutservice:latest"

sudo su - root -c "docker tag adservice:latest $currencyservice:latest"
sudo su - root -c "docker push $currencyservice:latest"

sudo su - root -c "docker tag adservice:latest $emailservice:latest"
sudo su - root -c "docker push $emailservice:latest"

sudo su - root -c "docker tag adservice:latest $frontend:latest"
sudo su - root -c "docker push $frontend:latest"

sudo su - root -c "docker tag adservice:latest $loadgenerator:latest"
sudo su - root -c "docker push $loadgenerator:latest"

sudo su - root -c "docker tag adservice:latest $paymentservice:latest"
sudo su - root -c "docker push $paymentservice:latest"

sudo su - root -c "docker tag adservice:latest $shippingservice:latest"
sudo su - root -c "docker push $shippingservice:latest"

sudo su - root -c "docker tag adservice:latest $productcatalogservice:latest"
sudo su - root -c "docker push $productcatalogservice:latest"

sudo su - root -c "docker tag adservice:latest $recommendationservice:latest"
sudo su - root -c "docker push $recommendationservice:latest"

#cd /home/ec2-user/ISC-OB/deployment_servicios
#terraform init
#terraform apply -auto-approve

# Obtengo la url del loadbalancer
#url=$(kubectl get all -n boutique | grep -o .*.us-east-1.elb.amazonaws.com | awk '{print $NF}')

# Instalacion del metrics server
#kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Instalacion del horizontal autoscaler sobre el frontend
#kubectl autoscale deployment frontend -n boutique --cpu-percent=30 --min=1 --max=10

# Genero tráfico sobre la página
# kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://$url; done"
