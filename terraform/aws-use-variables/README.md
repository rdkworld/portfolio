# Use Dynamic Variables in Terraform


1. Create variable names and default initial values in  ```Variables.tf``` file 

2. Run terraform processes as applicable

3. Optionally, override the default variable value using ```-var "instance_name="```

```terraform apply -var "instance_name=YetAnotherName"```
