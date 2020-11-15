# Objetivo de este apartado

Recoge el código necesario para crear un backend de Terraform sobre S3, par alamacenar los archivos de estado. Las ventajas de trabajar con este tipo de backend, en lugar de utilizar almacenamiento local, son:
- La posibilidad de permitir el trabajo colaborativo.
- Poder ejecutar acciones sobre la infraestructura desplegada, a través de Terraform, desde cualquier equipo.
- Poder usar el estado de un despliegue como datasource para otro, evitando el tener de replicar configuraciones en variables. Se verá un ejemplo de este uso en este proyecto, a la hora de desplegar un grupo de nodos gestionados por EKS.

# Componentes que se crean en este punto:

- Un bucket de S3.
- Una tabla en DynamoDB para controlo de bloqueo de objetos en el bucket para evitar que se escriba en el mismo archivo de estado de forma simultánea desde dos o más puntos distintos.
- Una policy IAM que permite trabajar tanto con el bucket, como con la tabla de DyanmoDB.
- Un usuario IAM para API al que se le aplicará la policy creada, para usarlo en las tareas de gestión del bucket y la tabla DynamoDB.

# Contenido

En este apartado se incluyen los siguientes contenidos:
- **init.tf**: en este archivo se incluye el código de configuración del provider de AWS.
- **main.tf**: en este archivo se incluye el código que crea en sí la infraestructura, llamando a los módulos de **bucket** y **bucket_iam**.
- **modules**: directorio en donde se incluyen las definiciones de los módulos de **bucket** y **bucket_iam**.
  - **bucket**: directorio que recoge los archivos para crear tanto el bucket de S3, como la tabla de DynamoDB.
  - **bucket_iam**: directorio que recoge los archivos para crear tanto la policy como el usuario que se usarán para gestionar el Bucket y la tabla DunamoDB.
- **output.tf**: incluye el código para los outputs del despliegue de esta parte de la infraestructura. Entre ellos están el **access_key** y **secret_key** del usuario IAM, para disponer de ellos y usarlos en otros puntos del despliegue.
- **terraform.tfvars**: incluye la asignación de valores para inputs (variables) del despliegue de la infraestructura.
- **variables.tf**: incluye la definición de inputs (o variables) que se usa en el despliegue de la infraestructura.

# Cómo lanzarlo
