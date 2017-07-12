# Infra-Code
AWS Infrastructure Code for IPP Regional Web

## Dependencies
- [Ansible](http://docs.ansible.com/ansible/intro_installation.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://www.terraform.io)

## Setting up VPC using Terraform

```bash
cd provisioners/vpc
export AWS_ACCESS_KEY_ID=xxxx
export AWS_SECRET_ACCESS_KEY=xx/xx/xx
export AWS_DEFAULT_REGION=<region_for_your_vpc>
```

### Notes:

1. You need to update the tfvars for your environment
1. Once you run the script please copy your tfstate to a environment specific directory(Never create/modify tfstate manually, it is automatically generated)
1. **Important: Do not run this against existing aws environments with VPC**

To provision an environment:

```bash
$ terraform get -var-file="environment.tfvars"
$ terraform plan -var-file="tfvars/<website>/<environment>-<aws_region>.tfvars" --state="tfstate/<website>/<environment>/terraform.tfstate"
```

Example:

```bash
$ terraform plan -var-file="tfvars/ipropertymy/development-ap-southeast-1.tfvars" --state="tfstate/ipropertymy/development/terraform.tfstate"
$ terraform apply -var-file="tfvars/ipropertymy/development-ap-southeast-1.tfvars" --state="tfstate/ipropertymy/development/terraform.tfstate"
```

## For Cloudformation

### How to run the deployment task.

##### 1. export your AWS keys in env.

```sh
export AWS_REGION="<ap-southeast-1 or ap-southeast-1>"
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

```bash
ansible-playbook solr.yml -i inventory/singapore/staging -vvvv
```

### Add a new deployment task

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

-----

### How to create AMI's

```sh
ansible-playbook ami.yml -i inventory/staging/ -e "private_key_file=/home/hash/aws/awscloud-squarefoot-staging-singapore.pem"
```

## For Windows

*  vagrant up --provider virtualbox


# Diagram of  deployment

### Using ALB
                                                      ----------- Record in Route53      
                                                      |
                                                      |
                                              ----------------
                                              |   ALB(fixed) |
                                              ----------------
                                                      |
                                                      |
                                              -----------------
                                              |    Lisener    |
                                              -----------------
                                                      |
                                              -----------------
                                              | listener rules | ...... (multi rules to different Target Groups)
                                              -----------------
                                                      | 
                                                      |
                                             --------------------
                                             |   Target Group   |  ......  (multi Target Groups)
                                             --------------------
                                                 |           |    
                       ---------------------------           ----------------
                       |                                                    |    
     ------------------|-------------------------------  -------------------|--------------------------------
     |  Stack A (Live) |                              |  |   Stack B        |                               |        
     |          ---------------                       |  |            -------------                         |        
     |          |     ASG     |                       |  |            |    ASG    |                         |        
     |          ---------------                       |  |            -------------                         |         
     |                 |                              |  |                  |                               |        
     |                 |                              |  |                  |                               |        
     |      -----------------------                   |  |        ----------------------                    |        
     |      | LaunchConfiguration |                   |  |        | LaunchConfiguration |                   |        
     |      -----------------------                   |  |        ----------------------                    |        
     |                |                               |  |                  |                               |         
     |         ---------------    ------------------- |  |         ------------------  -------------------  |        
     |         | ECS cluster  |   | Task Definition | |  |         |   ECS cluster  |  | Task Definition |  |        
     |         ---------------    ------------------- |  |         ------------------  -------------------  |        
     |                    |         |                 |  |                       |        |                 |        
     |                  --------------                |  |                     --------------               |        
     |                  |  ECService  |               |  |                     |  ECService  |              |        
     |                  --------------                |  |                     --------------               |        
     --------------------------------------------------  ----------------------------------------------------     


### Using ELB

                                          --------------   Record in Route53
                                          |
                                          |
                                    --------------
                                    | ELB(fixed) | 
                                    --------------
                                         |  |    
                       ------------------   --------------------
                       |                                       |    
     ------------------|------------------  -------------------|-----------------
     |  Stack A (Live) |                 |  |   Stack B        |                |        
     |          ---------------          |  |            -------------          |         
     |          |     ASG     |          |  |            |    ASG    |          |        
     |          ---------------          |  |            -------------          |         
     |                 |                 |  |                  |                |        
     |                 |                 |  |                  |                |        
     |      -----------------------      |  |        ----------------------     |        
     |      | LaunchConfiguration |      |  |        | LaunchConfiguration |    |        
     |      -----------------------      |  |        ----------------------     |        
     |                |                  |  |                  |                |        
     |          ------------             |  |            ------------           |        
     |          |  ......  |             |  |            |  ......  |           |        
     |          ------------             |  |            ------------           |        
     |                                   |  |                                   |        
     -------------------------------------  -------------------------------------     


## Run performance test
switch to the path `provisioners/performance/squarefoot-legacy`

* run `bundle install` to install missing gems.
* run following command to start a production performance testing which will launch a task in flood.io

  `bundle exec ruby hp_test.rb --mode prod --api-key xxxxxx --flood-name your-flood-name --region aws-region-of-flood --duration 600 --api-grid grid-in-flood-io`

---
Spend some time on [ansible playbooks](http://docs.ansible.com/ansible/playbooks.html) and [cloudformation](https://aws.amazon.com/cloudformation/)

![infra-code](https://d13yacurqjgara.cloudfront.net/users/364919/screenshots/3136802/infracode_1x.png)

