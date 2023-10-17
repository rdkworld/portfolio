
# Store remote state in secure and encrypted environment (Terraform Cloud  or similar providers)

Terraform Cloud allows teams to easily version, audit, and collaborate on infrastructure changes. It also securely stores variables, including API tokens and access keys, and provides a safe, stable environment for long-running Terraform processes.


1. Add a ```cloud``` block to main.tf file 

2. Login locally to terraform ```terraform login``` and authenticate using Terraform API token

3. Re-initialize your configuration and migrate local state file to Terroform cloud by doing ```terraform init```

4. Delete local state file by doing ```rm terraform.tfstate```

5. Set workspace variables in Terraform Cloud by going to workspace created from ```terraform init``` by going to variables. Create and add these - AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as environment variables

6. Now, do a ```terraform apply``` or optionally first ```terraform plan```
