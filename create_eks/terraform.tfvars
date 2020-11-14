region       = "eu-west-1"
project_name = "Demo_bk8s"

cidr            = "10.0.0.0/16"
private_subnets = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]


name_prefix = "all_worker_management"
cidr_blocks = ["111.111.111.111/32"]

