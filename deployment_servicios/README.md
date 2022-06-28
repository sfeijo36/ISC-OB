### [Deployment_Servicios](./deployment_servicios)

  En esta carpeta se encontraran los archivos de deployment correspondientes a cada servicio de la solucion.

[variables.tf](./deployment_servicios/variables.tf)

  * Utilizamos variables para las imagenes creadas en ECR, que luego seran utilizadas en cada deployment.

  * Existe un archivo .tf para cada servicio que requiere nuestra aplicacion web. Cada uno de ellos fue creado en formato terraform a partir de un archivo yaml.
  * En cada uno de estos archivos de deployment, la imagen esta como variable la cual es tomada de nuestro archivo de variables.

[config](./deployment_servicios/config)

  * Este archivo contiene la informacion de nuestro cluster EKS, previamente creado mediante el deploy de nuestra infra. El mismo es necesario para utilizar en el archivo de [provider.tf](./deployment_servicios/provider.tf).
