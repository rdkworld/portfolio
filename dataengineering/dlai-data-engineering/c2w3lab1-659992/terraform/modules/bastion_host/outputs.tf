output "project" {
  value = var.project
}

### START CODE HERE ### (~ 19 lines of code)

# Define an output for the id of the EC2
# instance
output "bastion_host_id" {
  value = None.None.id
}

# Define an output for the public DNS of the EC2
# instance
output "bastion_host_dns" {
  value = None.None.None
}

# Define an output for the hostname or address of the RDS
output "db_host" {
  value = None.None.None
}

# Define an output for the port of the RDS
output "db_port" {
  value = None.None.None
}

# Define an output for the username of the RDS
output "db_master_username" {
  value = None.None.None
}

# Define an output for the master password of the RDS
output "db_master_password" {
  value     = None.None.None
  sensitive = true
}

### END CODE HERE ###