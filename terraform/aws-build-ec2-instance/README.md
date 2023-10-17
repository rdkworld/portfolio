
# Build AWS Infrastructure

## Goal is to provision an EC2 instance on Amazon Web Services (AWS)

1. To use your IAM credentials to authenticate the Terraform AWS provider, set the AWS_ACCESS_KEY_ID environment variable.

```export AWS_ACCESS_KEY_ID=```

2. Set the secret
```export AWS_SECRET_ACCESS_KEY=```

3. Navigate to the folder and initialize the project, which downloads a plugin that allows Terraform to interact with providers

```terraform init```

4. Format the files for consistent formatting (best practices)

```terraform fmt```

5. Syntactically validate the configuration and make sure it is consistent as well

```terraform validate```

6. Create validate the blueprint
```terraform plan```

7. Provision the actual resource with apply
```terraform apply```

8. Inspect the state file which stores the IDs and properties of the resources it manages in this file, so that it can update or destroy those resources going forward

```terraform show```

4. Manage (or List) Terraform states 

```terraform state list```
