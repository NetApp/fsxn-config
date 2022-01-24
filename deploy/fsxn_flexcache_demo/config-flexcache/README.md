
# Configure a Flexcache

## Set the variables
1. Edit the var_demo.yml file and put in the information of the FSxN instances you deployed with Terraform. You can find all necessary information in the aws console or in the terraform output.
2. You need the filesystem ids for the cluster names, the management ip addresses and the intercluster ip addresses
3. For the flexcache fill in the name, mountpoint and size of the cache volume.

## Run the playbooks
1. Run create-flexcache-relationship.yml. It creates the cluster peer between both FSxN instances. Then vserver peering is done. Now you have all prerequisites to create the flexcache.
        ansible-playbook create-flexcache-relationship.yml
2. Run create-flexcache-volume.yml to create the flexcache
- **Attention - unfortunately there is a bug in the vserver peer module for FSxN. The vserver peer stays in pending state. To fix this you have to manually run "vserver peer accept -vserver <vserver> -peer-vserver <peer-vserver> on the peer FSxN instance. The issue is reported and I'm working on a workaround for the current playbook but it's not done yet.**

## Example output
    FsxId092d3dcdeb87ca58b::> vserver peer show
                Peer        Peer                           Peering        Remote
    Vserver     Vserver     State        Peer Cluster      Applications   Vserver
    ----------- ----------- ------------ ----------------- -------------- ---------
    svm_skdemo02 
                svm_skdemo01 
                            pending      FsxId0e711a91c5abe695c 
                                                        flexcache      svm_skdemo01

    FsxId092d3dcdeb87ca58b::> vserver peer accept -vserver svm_skdemo02 -peer-vserver svm_skdemo01 

    Info: [Job 54] 'vserver peer accept' job queued 

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
