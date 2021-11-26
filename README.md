# fsxn-config
Config Management for FSxN Filesystems
The repo contains two folders. One for deployment with terraform and the second for configuration with ansible.

## Deployment (Terraform)
- As a prerequisite you have to configure the aws cli with your credentials to access aws
- Edit the main.tf file and put in your settings
- Then you can do the normal terraform procedure to deploy the fsxn filesystem
- Currently the terraform provider only creates the filesystem. You have to create the svm via cli. There's an example in the folder aws_cli

## Configuration (Ansible)
- Edit the variables file for your environment

### Playbooks
- Create nfs volume
- Create cifs volume, DNS, Cifs Server and cifs share
- more playbooks to come
