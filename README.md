
# Deployment and Config Management for FSxN Filesystems
The repo contains two folders. One for deployment with terraform and the second for configuration with ansible. As a Cloud Solution Architect for AWS with NetApp I use this code to deploy a complete fsxn filesystem with different volumes for cifs and nfs for demo purposes. With that I can easily spin up a demo environment and destroy it afterwards so that I get a quick and cost-effective environment to showcase the solution or do some testings with fsxn. Feel free to adapt it according to your needs.

## Deployment (Terraform)
- As a prerequisite you have to configure the aws cli with your credentials to access aws
- Edit the terraform.tfvars file and put in your settings
- Create secret.tfvars file and provide sensitiv information. You can use the sample_secret.tfvars file as a reference
- When running terraform plan make sure to specify -var-file secret.tfvars otherwise you will get prompted for the sensitive information
- Then you can do the normal terraform procedure to deploy the fsxn filesystem
- There are different directories to create a filesystem and an svm, only an svm or only a volume

## Configuration (Ansible)
- Edit the variables file and put in the settings for your environment
- Sensitive information can be put into the vault_vars.yml file. Then it should be encrypted with ansible-vault. In the ansible.cfg there's a file specified where you can store your decrypt password. It defaults to ~/.vault_password and can be changed on your behalf. There's also a sample_vault_vars.yml file as a reference that you can copy.

### Playbooks
- Create nfs volume
- Create cifs volume, DNS, Cifs Server and cifs share
- Plus corresponding remove playbooks
