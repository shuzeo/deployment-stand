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