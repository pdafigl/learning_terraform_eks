# Objetivo de este apartado

Recoge el código necesario para crear un grupo de nodos gestionados por el clúster EKS. Crea dos nuevas instancias en subredes públicas (puede modificarse par que use las subredes privadas. 
Se usarán como valores de entrada para el despliegue de esta parte de la infraestructura,el archivo de estado del despliegue de EKS, de esta forma se reducen las tareas de configuración y definición de inputs, así como tambiń se reducen las posibilidades de cometer errores definiendo los valores para esos inputs.
Para el paso de credenciales, se usará de nuevo perfiles, como para el caso del despliegue de EKs, y se usará el mismo archivo **~/.aws/credentials**.

# Componentes que se crean en este punto:

- Grupo de nodos gestionado desde EKS.
- Dos instancias EC2 asociadas al grupo de nodos.

# Contenido

En este apartado se incluyen los siguientes contenidos:
- **ini.tf**: contiene la configuración del provider AWS, la configuración del backend para este punto del despliegue de infraestructura, y la configuración para usar el archivo de estado del despliegue de EKS como datasource para el despliegue del grupo de nodos.
- **main.tf**: contiene el código necesario para llevar a cabo el despliegue el grupo de nodos.
- **output.tf**: contiene las definiciones de los outputs del despliegue.
- **terraform.tfvars**: contiene la asignación de valores para los inputs (o variables).
- **variables.tf**: contiene la definición de inputs (o variables).

# Cómo lanzarlo

Como ya se ha dicho, se usará la misma configuración de credenciales que para el caso del despliegue del clúster EKS. Así que, para lanzar el despliegue del grupo de nodos, nos ubicaremos en el directorio create_node_group y se inicializará el entorno Terraform para descargar todas las librerías necesarias. Para ello se lanza:

```bash
terraform init
``` 
Una vez hecho esto, se crea el plan de ejecución y se vuelca a un archivo **.out**:

```bash
terraform plan -out archivo.out
``` 

Ahora solo queda desplegar el grupo de nodos lanzando:

```bash
terraform apply archivo.out
```

Se pueden ver los nuevos nodos:

```bash
$ kubectl get nodes
NAME                                       STATUS   ROLES    AGE   VERSION
ip-10-0-0-141.eu-west-1.compute.internal   Ready    <none>   56m   v1.18.9-eks-d1db3c
ip-10-0-1-170.eu-west-1.compute.internal   Ready    <none>   55m   v1.18.9-eks-d1db3c
ip-10-0-1-172.eu-west-1.compute.internal   Ready    <none>   55m   v1.18.9-eks-d1db3c
ip-10-0-3-5.eu-west-1.compute.internal     Ready    <none>   70s   v1.18.9-eks-d1db3c
ip-10-0-4-187.eu-west-1.compute.internal   Ready    <none>   70s   v1.18.9-eks-d1db3c
``` 

