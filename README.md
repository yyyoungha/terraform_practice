# Terraform Practice
This is a _repository_ for _practicing_ with _terraform_.

# How to use
How to provision resources inside a directory is shown below.

    cd vpc-cicd

## 1. Make tfvars file
Tfvars file is not included. So you need to define the value of variables first.
 
    cp ./config/cicd.template ./config/cicd.tfvars
    vi cicd.tfvars

## 2. Initialize
    terraform init
    
## 3. Plan
    terraform plan -state=terraform_cicd.tfstate -var-file=./config/cicd.tfvars
    
## 4. Apply
    terraform apply -auto-approve -state=terraform_cicd.tfstate -var-file=./config/cicd.tfvars

## 5. Destroy
    terraform destroy -auto-approve -state=terraform_cicd.tfstate -var-file=./config/cicd.tfvars
