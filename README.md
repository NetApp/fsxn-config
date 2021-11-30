# fsxn-config
Config Management for FSxN Filesystems
The repo contains two folders. One for deployment with terraform and the second for configuration with ansible.

## Deployment (Terraform)
- As a prerequisite you have to configure the aws cli with your credentials to access aws
- Edit the terraform.tfvars file and put in your settings
- Create secret.tfvars file and provide sensitiv information. You can use the sample_secret.tfvars file as a reference
- Then you can do the normal terraform procedure to deploy the fsxn filesystem
- There are different directories to create a filesystem and an svm, only an svm or only a volume

## Configuration (Ansible)
- Edit the variables file for your environment

### Playbooks
- Create nfs volume
- Create cifs volume, DNS, Cifs Server and cifs share
- more playbooks to come
