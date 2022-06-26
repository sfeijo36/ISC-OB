
# OBLIGATORIO ISC


<p align="center">
<img src="docs/Hipster_HeroLogoCyan.svg" width="300" alt="Online Boutique" />
</p>

Online Boutique es una aplicación de demostración de microservicios nativa de la nube. Online Boutique consta de una aplicación de microservicios de 10 niveles. La aplicación es una aplicación de comercio electrónico basada en la web donde los usuarios pueden buscar artículos, agregarlos al carrito y comprarlos.

Capturas - GIFs del funcionamiento de la pagina
<p align="center">
<img src="docs/Multimedia1.gif" width="800" alt="Funcionamiento de la página" />
</p>

## Arquitectura
  Diagrama
  Explicación microservicios
  
## DATOS DE LA INFRAESTRUCTURA (TIPO DE INSTANCIA, BLOQUES CIDRs, FIREWALLING, ETC)

  * Tipo de instancias:
    * 

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

## Archivos de la implentacion

[Deployment_Infra](./deployment_infra)

En esta carpeta encontraremos los archivos .tf necesarios para el deploy de la infra a implementar. Entre los que se encuentra la configuracion de la red, y el despligue de un Cluster EKS.


[variables.tf](./deployment_servicios/variables.tf)

En este archivo almacenamos las variables que utilizaremos en la ejecucion terraform. La ventaja de usar variables en dicho archivo, es que en caso de que cambie algun dato, simplemente se cambiara el valor en dicho archivo, y no en todos los archivos que utilizen ese valor.

provider.tf

Se define el provider, en nuestro caso aws con la region a utilizar.

red.tf

Definimos todos los servicios a utilizar en nuestra red, declarando primero nuestro vpc con su correspondiente CIDR.

Utilizamos el recurso vpc previamente creado, referenciandolo en los restantes recursos a crear de la siguiente forma:

aws_vpc.vpc-obligatorio.id

Se utilizaron las variables previamente mencionadas, referenciandolas de la siguiente forma:

var.nombre_asignado

eks.tf

En este archivo se encuentra el deployment de nuestro cluster, en conjunto con los workers que lo conforman.
Al igual que en el archivo de red.tf, se utilizan variables mediante el llamado de las mismas con var.nombre_asignado y la referencia de recursos previamente creados.
  
Deployment Servicios
En esta carpeta se encontraran los archivos de deployment correspondientes a cada servicio de la solucion.

Cómo pueden comenzar los usuarios con el proyecto.

Dónde pueden recibir ayuda los usuarios con tu proyecto

Quién mantiene y contribuye con el proyecto.
