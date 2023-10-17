
# Create Terraform Infrastructure with Docker

## Goal is to provision and destroy an NGINX webserver with Terraform.

1.Initialize the project, which downloads a plugin that allows Terraform to interact with Docker

```terraform init```

2.Provision the NGINX server container with apply

```terraform init```

3.Verify NGINX instance to view container running in Docker via Terraform

```docker ps```

4.Destroy Resources (& stop the container as well)

```terraform destroy```
