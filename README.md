# Infra-Code
AWS Infrastructure Code for IPP Regional Web

##For Setting up VPC using Terraform

* cd terraform-vpc
* export AWS_ACCESS_KEY_ID=xxxx
* export AWS_SECRET_ACCESS_KEY=xx/xx/xx
* export AWS_DEFAULT_REGION=eu-west-1
* terraform get -var-file="network.tfvars"
* terraform plan -var-file="network.tfvars"
* terraform apply -var-file="network.tfvars"

####Note: Do not run this against existing aws environments with VPC

## For Cloudformation

### Dependencies
- [Ansible](http://docs.ansible.com/ansible/intro_installation.html)
- [AWS CLI](https://aws.amazon.com/cli/)

### How to run the deployment task.
##### 1. export your AWS keys in env.
```sh
export AWS_REGION="ap-southeast-1 or ap-southeast-1"
export AWS_ACCESS_KEY_ID=xxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxx
```
##### 2. update the `inventory` file.

```yaml
[solr:vars]
ab=a
build=build-171
```

##### 3. run the ansible task.

`ansible-playbook solr.yml -i inventory/singapore/staging -vvvv`

### add a new deployment task
##### 1. add a playbook
```yaml
---
- hosts: solr
  connection: local
  gather_facts: False
  roles:
    - solr
```

##### 2. add role
* create a new role folder under `roles` folder.
* add `tasks` for this role.

##### 3. set params and template
* add cloudformation template in `cloudformation` folder.
* add host and customized params in `inventory` file.
* add common params in `all` file under `group_vars` folder.

## For Windows

*  vagrant up --provider virtualbox

---
Spend some time on [ansible playbooks](http://docs.ansible.com/ansible/playbooks.html) and [cloudformation](https://aws.amazon.com/cloudformation/)

![infra-code](https://d13yacurqjgara.cloudfront.net/users/364919/screenshots/3136802/infracode_1x.png)
