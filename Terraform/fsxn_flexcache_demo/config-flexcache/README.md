
# Configure a Flexcache

## Set the variables
1. Edit the var_demo.yml file and put in the information of the FSxN instances you deployed with Terraform. You can find all necessary information in the aws console or in the terraform output.
2. You need the filesystem ids for the cluster names, the management ip addresses and the intercluster ip addresses
3. Fill in the name, mountpoint and size of the cache volume for the flexcache.

## Run the playbooks
1. Run `ansible-playbook create-flexcache-relationship.yml`. It creates the cluster and vserver peer between both FSxN instances. Now you have all prerequisites to create the flexcache.
2. Run `ansible-playbook create-flexcache-volume.yml` to create the flexcache
3. Run `ansible-playbook modify-flexcache-volume.yml` to set an export policy and mount the flexcache volume

## Result
Vservers are peered and there's a flexcache volume on the second filesystem with the origin volume on the first filesystem.

    FsxId092d3dcdeb87ca58b::> vserver peer show
                Peer        Peer                           Peering        Remote
    Vserver     Vserver     State        Peer Cluster      Applications   Vserver
    ----------- ----------- ------------ ----------------- -------------- ---------
    svm_skdemo02 
                svm_skdemo01 
                            peered       FsxId0e711a91c5abe695c 
                                                        flexcache      svm_skdemo01

    FsxId092d3dcdeb87ca58b::> flexcache show
    (volume flexcache show)
    Vserver Volume      Size       Origin-Vserver Origin-Volume Origin-Cluster
    ------- ----------- ---------- -------------- ------------- --------------
    svm_skdemo02 
            vol_flexcache01 
                        1GB        svm_skdemo01   vol_skdemo01  
                                                        FsxId0e711a91c5abe695c
