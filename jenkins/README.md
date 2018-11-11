Jenkins setup
--------------

```
$ cd ./eq-exp/jenkins
$ vagrant up

```

It will ask you for your root password to the record to hosts file, you should end up with something like this 

```
...
    jenkins:         "Wants": "network-online.target", 
    jenkins:         "WatchdogTimestampMonotonic": "0", 
    jenkins:         "WatchdogUSec": "0"
    jenkins:     }
    jenkins: }
    jenkins: META: ran handlers
    jenkins: META: ran handlers
    jenkins: 
    jenkins: PLAY RECAP *********************************************************************
    jenkins: 127.0.0.1                  : ok=10   changed=8    unreachable=0    failed=0   
    jenkins: -- ---------------- --
    jenkins: -- END Installation --
    jenkins: -- ---------------- --

```
now from the command line execute the following command to obtain the initial jenkins admin passowrd

```
$ vagrant ssh jenkins
$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```


Now hit your browser at `http://192.168.10.11:8080/` and enter this intial admin password, you have a jenkins master up and running with vagrant

At the end to destroy the node, you shall execute which will ask for your sudo password

```
$ vagrant destroy
    jenkins: Are you sure you want to destroy the 'jenkins' VM? [y/N] y
==> jenkins: Forcing shutdown of VM...
==> jenkins: Destroying VM and associated drives...
==> jenkins: Pruning invalid NFS exports. Administrator privileges will be required...
Password:

```
