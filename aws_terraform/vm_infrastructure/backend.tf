terraform {
  # S3 bucket needs to be created in AWS IU - enable Bucket Versioning and Default encryption
  backend "s3" {
    bucket = "myportfoliobucketprod"
    key    = "s3_backend.tfstate"
    ### cretae a DynamoDB resource in AWS with "Partition key=LockID" and just copy/paste the name of the table### 
    # - this configuration in s3 backend willl ensure that terraform commands can't be run in the same time (example: apply and destroy in the same time)
    dynamodb_table = "myportfolio-s3-state-lock"
    region         = "eu-central-1"
    # no need to specify the keys values as we are exporting them in the command line
    # access_key     = "***"
    # secret_key     = "***"
  }
}