# How to

## 0. Make tfvars file
Tfvars file is not included. So you need to define the value of variables first.
 
    cp ./config/cicd.template ./config/cicd.tfvars
    vi cicd.tfvars

## 1. Initialize
    terraform init
    
## 2. Plan
    terraform plan -state=terraform_cicd.tfstate -var-file=./config/cicd.tfvars
    
## 3. Apply
    terraform apply -auto-approve -state=terraform_cicd.tfstate -var-file=./config/cicd.tfvars

## 4. Destroy
    terraform destroy -auto-approve -state=terraform_cicd.tfstate -var-file=./config/cicd.tfvars

