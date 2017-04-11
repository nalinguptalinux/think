# Jenkins

To launch Jenkins in a development environment using Ansible

1. Make sure the VPC is already created.
1. Make sure the required variables are defined in `inventory/<website>/dev/group_vars/all` and `inventory/<website>/dev/inventory`.
1. Export `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` into environment.

Executing via Ansible is as simple as:

```bash
ansible-playbook -i inventory/<website>/dev/inventory jenkins.yml -v
```