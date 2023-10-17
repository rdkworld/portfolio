# Change AWS Infrastructure

## Goal is to change an EC2 instance on Amazon Web Services (AWS) using Terraform. While Terraform can change/update some attributes, most resources will need to be destroyed and created again

1. Make the required configuration change in ```main.tf``` file 

2. Do a ```terraform plan```

4. Do a ```terraform apply```. Terraform will destroy existing instance and create a new one
