# Objetivo de este apartado

Recoge el código necesario para crear un clúster EKS base, con 3 nodos worker. Estos nodos se unirán al clúster de Kubernetes, pero no se crearán como grupos de nodos, que son gestionados por EKS directamente. Además de esta parte, creará todo lo ncesario en cuanto a la red virtual, subredes, grupos de seguridad, etc.

# Componentes que se crean en este punto:
En este apartado se crean los siguientes componentes:
- VPC
- Subredes, creando una subred en cada una de las zonas de disponbilidad de la región en la que se despliega el clśuter EKS. Se creará en cada zona una subred privada y otra pública.
- Un Internet Gateway.
- Una tabla de rutas.
- Grupo de seguridad que se asociarán a las instancias.
- Una IP elástica que se podrá asociar a las máquinas creadas durante el despliegue del clúster, para futuras tareas de mantenimiento facilitando el acceso a las mismas, ya que se crearán solo en la red privada, no tendrá una IP pública.
- Clúster EKS.
- Tres instancias EC2 asociadas al clúster de Kubernetes.
- Dos grupos de escalado en el que se reparrtirán las instancias creadas. No se cran con reglas de escalado, se tendrían que configurar a posteriori, o incluir el código que las cree.
- Políticas y roles de IAM para la gestión del clúsclear

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


