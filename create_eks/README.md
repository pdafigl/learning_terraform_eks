# Objetivo de este apartado

Recoge el código necesario para crear un clúster EKS base, con 3 nodos worker. Estos nodos se unirán al clúster de Kubernetes, pero no se crearán como grupos de nodos, que son gestionados por EKS directamente. Además de esta parte, creará todo lo ncesario en cuanto a la red virtual, subredes, grupos de seguridad, etc.

# Componentes que se crean en este punto:
En este apartado se crean los siguientes componentes:
- Una VPC con una serie de subredes, creando una subred en cada una de las zonas de disponbilidad de la región en la que se despliega el clśuter EKS. Se creará en cada zona una subred privada y otra pública. Además crea un NAT Gateway asociado a la VPC y una tabla de rutas.
- Grupo de seguridad que se asociarán a las instancias.
- Clúster EKS.
- Tres instancias EC2 asociadas al clúster de Kubernetes. Se repartirán en dos grupos de escalado.
- Políticas y roles de IAM para la gestión del clúster.
- Archivo Kubeconfig asociado al clúster.

# Contenido

En este apartado se incluyen los siguientes contenidos:
- **eks.tf**: contiende el código para crear el clúster de EKS, junto con todos los componentes asociados al clúster y los nodos worker.
- **init.tf**: contiene la configuración del provider de AWS, y la configuración para usar el bucket S3 creado en el apartado de **create_backend** 
- **k8s.tf**: contiene un ejemplo de configuración del provider de Kubernetes,a partir de los componentes creados por el despliegue de EKS con Terraform, y que permitiría usar los resources asociados al provider para crear otros elementos de Kubernetes directamente sobre este despliegue de EKS.
- **output.tf**: contiene la definición de outputs para el despliegue. En este punto tienen mayr importancia, ya que no solo serán para mostrar información por pantalla, sino que se usarán como valores de entradas para inputs en el punto de creación de grupos de nodos, dentro del apartado de **create_node_group**.
- **terraform.tfvars**: contiene valores para inputs (o variables) del despliegue.
- **variables.tf**: contiene la definición de inputs (o variables) necesarias para el despliegue.
- **vpc.tf**: contiene el código para crear todo el apartado de red virutal, subredes, internet gateway, grupos de seguridad, etc.

# Cómo lanzarlo

Nos ubicaremos en el directorio create_eks. Para este caso, las credenciales las pasaremos creando perfiles dentro del archivo **~/.aws/credentials**. Para crear este archivo se debe ejecutar el comando:

```bash
# aws configure
AWS Access Key ID: <access_key_usuario_principal> 
AWS Secret Access Key: <secret_key_usuario_principal> 
Default region name: <region_aws> 
Default output format: json
```

Este comando crea los archivos **~/.aws/credentials** y **~/.aws/config**. Nos centraremos en el archivo credentials. El comando crea un perfil **default** que usaremos para la configuración del provider AWS, como usuario principal para crear todos los componentes. Nos queda el crear el perfil para l uso del usuario creado en el puntode **create_backend**. Para ello editamos el archivo credentials, dejando el contenido de dicho archivo con una forma como ésta:

```bash
[default]
aws_access_key_id = <access_key_usuario_principal> 
aws_secret_access_key = <secret_key_usuario_principal> 

[tfstate]
aws_access_key_id = <access_key_usuario_backend> 
aws_secret_access_key = <secret_key_usuario_backend>
```

Recordad que se pueden ver las credenciales del usuario creado para el backend, lanzando el comando **terraform output** desde el directorio **create_backend**

Una vez hecha esta configuración, se lanzará el comando para inicialiar el entorno para el despliegue, haciendo que se descarguen todas las librerías necesarias para los distintos providers utilizados, para las módulos y recursos, etc.El comando a lanzar:

```hcl
terraform init
```

Para crear el plan de ejecución y hacerlo sobre un archivo **.out** que se usará después para realizar el despliegue, se lanzará:

```hcl
terraform plan -out archivo.out
```

Una vez se dispone del plan de ejecución, se lanza el despliegue:

```hcl
terraform apply archivo.out
```

Al finalizar el despliegue, se mostrarán una serie de salidas por pantalla, asociadas a los outputs definidos en el archivo **output.tf**. Estos valores toman más valor por lo comentado, el estado de este despliegue se usará como entrada de datos para el despliegue de grupos de nodo, y los valores a utilizar se toman de los outputs. Además, hay dos salidas que se usarán para crear un kubeconfig asociado al usuario del sistema con el que estemos lanzando el despliegue en nuestra máquina, permitiendo el utilizar kubectl directamente para trabajar con el clúster de Kubernetes desplegado en EKS. Los dos outputs que se usarán son:

```hcl
terraform output region
terraform output cluster_name
```

Para crear este archivo kubeconfig asociado a nuestro usuario de sistema en nuestra máquina, se lanzará lo siguiente:

```bash
aws eks --region $(terraform output region) update-kubeconfig --name $(terraform output cluster_name)
```

Y ya podremos trabajar con kubectl:

```bash
$ kubectl get nodes
NAME                                       STATUS   ROLES    AGE   VERSION
ip-10-0-0-141.eu-west-1.compute.internal   Ready    <none>   19m   v1.18.9-eks-d1db3c
ip-10-0-1-170.eu-west-1.compute.internal   Ready    <none>   19m   v1.18.9-eks-d1db3c
ip-10-0-1-172.eu-west-1.compute.internal   Ready    <none>   19m   v1.18.9-eks-d1db3c
```



