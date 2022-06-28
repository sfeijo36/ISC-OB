# Deployment_Infra

**Índice**

1. [Variables](#id1)

  En esta carpeta encontraremos los archivos .tf necesarios para el deploy de la infra a implementar. Entre los que se encuentra la configuracion de la red, y el despligue de un Cluster EKS.


[variables.tf](./deployment_infra/variables.tf)<a name="id1"></a>

  * En este archivo almacenamos las variables que utilizaremos en la ejecucion terraform. La ventaja de usar variables en dicho archivo, es que en caso de que cambie algun dato, simplemente se cambiara el valor en dicho archivo, y no en todos los archivos que utilizen ese valor.

[provider.tf](./deployment_infra/provider.tf)

  * Se define el provider, en nuestro caso aws con la region a utilizar.

[red.tf](./deployment_infra/red.tf)

  * Definimos todos los servicios a utilizar en nuestra red, declarando primero nuestro vpc con su correspondiente CIDR.

  * Utilizamos el recurso vpc previamente creado, referenciandolo en los restantes recursos a crear de la siguiente forma:

    * aws_vpc.vpc-obligatorio.id

   * Se utilizaron las variables previamente mencionadas, referenciandolas de la siguiente forma:

      * var.nombre_asignado

[eks.tf](./deployment_infra/eks.tf)

  * En este archivo se encuentra el deployment de nuestro cluster, en conjunto con los workers que lo conforman.
  Al igual que en el archivo de red.tf, se utilizan variables mediante el llamado de las mismas con var.nombre_asignado y la referencia de recursos       previamente creados.
