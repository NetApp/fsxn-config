
# Configure a Flexcache

## Set the variables
- Edit the var_demo.yml file and put in the information of the FSxN instances you deployed with Terraform. You can find all necessary information in the aws console or in the terraform output.
- You need the filesystem ids for the cluster names, the management ip addresses and the intercluster ip addresses
- For the flexcache fill in the name, mountpoint and size of the cache volume.

## Run the playbooks
- First run create-flexcache-relationship.yml. It creates the cluster peer between both FSxN instances. Then vserver peering is done. Now you have all prerequisites to create the flexcache
- Now run create-flexcache-volume.yml to create the flexcache
- **Attention - unfortunately there is a bug in the vserver peer module for FSxN. The vserver peer stays in pending state. To fix this you have to manually run "vserver peer accept -vserver <vserver> -peer-vserver <peer-vserver> on the peer FSxN instance. The issue is reported and I'm working on a workaround for the current playbook but it's not done yet.**
