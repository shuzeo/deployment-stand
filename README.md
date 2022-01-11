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

**Add vault file-password**

    echo 'password' > ansible/site/vault.password
    
For change password use `ansible-vault rekey`  
For decrypt use `ansible-vault decrypt`  
For encrypt use `ansible-vault encrypt`  
For view use `ansible-vault view`  
For edit use `ansible-vault edit`

**Add pipeline and run**

    - http://172.103.0.100:8080/
    - new item
    - pipeline
        - definition: SCM
        - SCM: Git
            - url: https://github.com/shuzeo/deployment-stand.git
            - branch: */main
            - script: jenkins/site.jenkinsfile
            
**Open site**

    http://172.103.0.101/            