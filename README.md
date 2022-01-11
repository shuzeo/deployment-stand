# deployment-stand

Testing deployment tools

**Start:**

    ./project start privileged

Parameter "privileged" gives access to all devices on the host system, it is not recommended to using in a production environment, only for testing. Needed for ansible to work correctly.

**Stop:**

    ./project stop

**Clear keys:**

    ./project ssh_clear

**Jenkins panel:**

    http://172.103.0.100:8080/
    
## deploy site    

**Add pipeline and run**

    - http://172.103.0.100:8080/
    - new item
    - pipeline
        - definition: SCM
        - SCM: Git
            - url: https://github.com/shuzeo/deployment-stand.git
            - branch: */main
            - script: jenkins/site.jenkinsfile

**Add vault file-password**

    sudo docker exec -it \
    $(sudo docker ps --format '{{.Names}}' | grep deployment-stand_master) \
    su jenkins bash -c 'dir=/var/jenkins/workspace/site/deployment-stand/ansible/site/; \
    mkdir -p $dir; echo "password" > $dir/vault.password'
    
Change password: `ansible-vault rekey`  
Decrypt: `ansible-vault decrypt`  
Encrypt: `ansible-vault encrypt`  
View: `ansible-vault view`  
Edit: `ansible-vault edit`
            
**Open site**

    http://172.103.0.101/            