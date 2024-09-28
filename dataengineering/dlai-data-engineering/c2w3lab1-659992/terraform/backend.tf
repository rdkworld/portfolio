# Configure the backend for Terraform using AWS
terraform {
  backend "s3" {
    ### START CODE HERE ### (~ 4 lines of code)
    bucket         = "None" # The name of the S3 bucket to store the state file
    key            = "None" # The key in the bucket where the state file will be stored
    region         = "None" # AWS region where the S3 bucket is located
    dynamodb_table = "None" # The name of the DynamoDB table to use for state locking
    ### END CODE HERE ###
    encrypt        = true
    
  }
}
