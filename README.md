# thinkofliving
Think of Living server migration


# Component 
  . Terraform
  . Cloudformation
  . Ansible
  . Ansible-Playbook


# Terraform
Example:

$ terraform plan -var-file="tfvars/TOL/Dev/dev-vars.tfvars" --state="tfstate/dev/thinkofliving-dev.tfstate"
$ terraform apply -var-file="tfvars/TOL/Dev/dev-vars.tfvars" --state="tfstate/dev/thinkofliving-dev.tfstate" 

# Cloudformation

  How to run the deployment task.
  
  1. export your AWS keys in env.
  export AWS_REGION="<ap-southeast-1 or ap-southeast-1>"
  export AWS_ACCESS_KEY_ID=xxxxxxxx
  export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxx
  
  2. update the inventory file.
  [wordpress:vars]
  ab=a
  build=build-171
  
  3. run the ansible task.
  ansible-playbook solr.yml -i inventory/dev -vvvv 
   
  4. Add a new deployment task and role
     . Add a playbook
 
  ---
  - hosts: wordpress
    connection: local
    gather_facts: False
    roles:
      - 
