Jenkins setup
--------------

```
$ vagrant up

```

It will ask you for your root password to the record to hosts file, you should end up with something like this 

```
...
    jenkins: (Reading database ... 45%
    jenkins: (Reading database ... 50%
    jenkins: (Reading database ... 55%
    jenkins: (Reading database ... 60%
    jenkins: (Reading database ... 65%
    jenkins: (Reading database ... 70%
    jenkins: (Reading database ... 75%
    jenkins: (Reading database ... 80%
    jenkins: (Reading database ... 85%
    jenkins: (Reading database ... 90%
    jenkins: (Reading database ... 95%
    jenkins: (Reading database ... 100%
    jenkins: (Reading database ... 
    jenkins: 56525 files and directories currently installed.)
    jenkins: Preparing to unpack .../daemon_0.6.4-1_amd64.deb ...
    jenkins: Unpacking daemon (0.6.4-1) ...
    jenkins: Selecting previously unselected package jenkins.
    jenkins: Preparing to unpack .../jenkins_2.138.3_all.deb ...
    jenkins: Unpacking jenkins (2.138.3) ...
    jenkins: Processing triggers for man-db (2.7.5-1) ...
    jenkins: Processing triggers for systemd (229-4ubuntu21.6) ...
    jenkins: Processing triggers for ureadahead (0.100.0-19) ...
    jenkins: Setting up daemon (0.6.4-1) ...
    jenkins: Setting up jenkins (2.138.3) ...
    jenkins: Processing triggers for systemd (229-4ubuntu21.6) ...
    jenkins: Processing triggers for ureadahead (0.100.0-19) ...
    jenkins: -- ---------------- --
    jenkins: -- END BOOTSTRAPING --
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