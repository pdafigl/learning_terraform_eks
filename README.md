# Objetivo del proyecto
Con este desarrollo se pretende faciltiar el código necesario para crear un clúster EKS utilizando Terraform. El dibujo final será:
- Creación y configuración de los componentes necesarios para que la gestión del estado de la infraestructura que maneja Terraform, resida en un bucket de S3.
- Creación y configuración de los componentes necesarios para el despliegue de un clúster base de EKS.
- Creación de un grupo de nodos gestionados desde EKS.

# Contenido del repositorio
En este repositorio se incluyen 3 directorios con el código para crear un clúster base de EKS utilizando Terraform. El contenido que se incluye es:
- **create_backend**: en este directorio se incluye el código necesario para crear un bucket en S3 para crear objetos en él de los estados de Terraform, de esta forma, se favorece el trabajo colaborativo, así como evitar borrados accidentales del archivo en local (en caso de no usar un backend Terraform), así como el borrado desde Terraform, ya que el bucket se crea con la opción de protegerlo ante borrado. Se tendrá que hacer un borrado manual del bucket creado. Además de este componente, se crea un tabla en DynamoDB para gestionar el bloqueo al bucket, para evitar que dos o más personas escriban en los estados de Terraform al mismo tiempo. Por último, crea un usuario y una policy con permisos necesarios para manejar tanto el bucket como la tabla en DynamDB.
- **create_eks**: en este directorio se incluye el código necesario para crear un clúster EKS básico, con tres nodos worker. Los nodos worker creados, no se crean como grupos de nodo, con lo que no serán gestionados directamente por el clúster EKS.
- **create_node_group**: en este directorio se incluye el código necesario para crear un grupo de nodos, que sí serán gestionados desde EKS. Crea dos instancias adicionales.

# Software necesario
- Terraform en una versión 0.13 o superior
- AWS CLI en una version 1.18 o superior
- kubectl en una versión 1.19 o superior

# Requisitos previos
Para poder lanzar todos los componentes, será necesario disponer de un usuario con permisos totales en:
- VPC
- EC2
- EKS
- IAM

Ya que se crearán y gestionarán elementos dentro de todos esos servicios. El usuario debe ser un usuario para poder lanzar la API, no de acceso a la consola de AWS. y deberá disponer de un **access key** y un **secret key** válidos. Para facilitar la configuración de estos elementos pra una prueba inicial, sin pararse a ver permisos concretos y más limitados, se puede crear un usuario con rol de **administrador**.

# Notas
- En cada directorio de este repositorio, se incluye un archivo **README.md** en donde se explica el contenido de cada directorio y los pasos necesarios para lanzar cada uno de los apartados del despliegue del clúster de EKS.
- Para evitar el incluir credenciales en el código, se recurrirán a dos estrategias, para mostrar distintas aleternativas para trabajar con este tipo de casuística. Una de ellas será la de usar variables de entorno, la otra alternativa, será la de utilizar perfiles creados a partir de una configuración base a partir del comando **aws configure**. Existen otras alternativas, como el uso de un gestor de claves como es Hashicorp Vault, por ejemplo.
