
# OBLIGATORIO ISC


<p align="center">
<img src="docs/Hipster_HeroLogoCyan.svg" width="300" alt="Online Boutique" />
</p>

Online Boutique es una aplicación de demostración de microservicios nativa de la nube. Online Boutique consta de una aplicación de microservicios de 10 niveles. La aplicación es una aplicación de comercio electrónico basada en la web donde los usuarios pueden buscar artículos, agregarlos al carrito y comprarlos.

Capturas - GIFs del funcionamiento de la pagina
<p align="center">
<img src="docs/Multimedia1.gif" width="800" alt="Online Boutique" />
</p>

## Arquitectura
  Diagrama
  Explicación microservicios
  
## DATOS DE LA INFRAESTRUCTURA (TIPO DE INSTANCIA, BLOQUES CIDRs, FIREWALLING, ETC)
  * CIDR VPC: 172.16.0.0/16
    * Subnet-1: 172.16.1.0/24
    * Subnet-2: 172.16.2.0/24
    
  * Security Group:
    * Reglas permit de entrada:
      * from_port = 80
      * to_port = 80
      * protocol = "tcp"
      * cidr_blocks = ["0.0.0.0/0"]

    * Reglas Permit de salida:
      * from_port = 0
      * to_port = 0
      * protocol = "-1"
      * cidr_blocks = ["0.0.0.0/0"] 
             
  * Zonas de disponibilidad:
    * us-east-1a
    * us-east-1b

## SERVICIOS DE AWS USADOS:
  * VPC
  * EKS (Elastic Kubernetes Service)
  * Instancia de EC2 (Utilizada como Bastion) 
  * ECR (Elastic Container Registry)

ETC.


  
Cómo pueden comenzar los usuarios con el proyecto.

Dónde pueden recibir ayuda los usuarios con tu proyecto

Quién mantiene y contribuye con el proyecto.
