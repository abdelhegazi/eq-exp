
# Concourse Lite

This vagrantfile deploys official `Concourse-lite` Vagrant image that is already prepared by concourse team.

## deployment

start vagrant box and this should show up

```
$ cd ./eq-exp/jenkins
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'concourse/lite'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'concourse/lite' is up to date...
==> default: Setting the name of the VM: concourse-lite_default_1541810215880_30794
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
    default: Adapter 2: hostonly
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: 
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default: 
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: The guest additions on this VM do not match the installed version of
    default: VirtualBox! In most cases this is fine, but in rare cases it can
    default: prevent things such as shared folders from working properly. If you see
    default: shared folder errors, please make sure the guest additions within the
    default: virtual machine match the version of VirtualBox you have installed on
    default: your host and reload your VM.
    default: 
    default: Guest Additions Version: 5.1.14
    default: VirtualBox Version: 5.2
==> default: Setting hostname...
==> default: Configuring and enabling network interfaces...
==> default: Mounting shared folders...
    default: /vagrant => /Users/abdel/Desktop/workspace/jobs/2018/equal-expert/eq-exp/concourse-lite
```

List the machine once you successfully start it
```
$ vagrant list
ALL:
3ee45064-8f4a-4401-8f08-be8effdfe246: minikube (Linux 2.6 / 3.x / 4.x (64-bit))
604e1ac6-eac6-493a-a6c1-1e5488009d0f: concourse-lite_default_1541810215880_30794 (Ubuntu (64-bit))
RUNNING:
3ee45064-8f4a-4401-8f08-be8effdfe246: minikube (Linux 2.6 / 3.x / 4.x (64-bit))
604e1ac6-eac6-493a-a6c1-1e5488009d0f: concourse-lite_default_1541810215880_30794 (Ubuntu (64-bit))
```

ssh to your concourse machine

```
$ vagrant ssh default
Welcome to Ubuntu 14.04.5 LTS (GNU/Linux 4.4.0-79-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

$ ifconfig 
<this should give you the ip of your instance, the default is 192.168.100.4>

```

The machine is pre-configured to come with ip  `http://192.168.100.4:8080/` which you can easily hit your browser loging with team `main` and you are having a basic concourse server running


You will need to install `fly` cli tool to interact with concourse server depends on your platform mac, linux or windows you can download it and start setting up pipeline. download page here `https://concourse-ci.org/download.html`


This is as example of running a pipeline to that concourse
```
$ fly -t eexpert login -c http://192.168.100.4:8080/ -n main
logging in to team 'main'

WARNING:

fly version (4.2.1) is out of sync with the target (3.2.1). to sync up, run the following:

    fly -t msf sync


target saved



$ fly -t eexpert sync
downloading fly from http://192.168.100.4:8080... 
 14.87 MiB / 14.87 MiB [============================================================================================================================================================================] 100.00% 0s
successfully updated from 4.2.1 to 3.2.1


$ fly -t eexpert teams
name
main


$ fly -t eexpert set-pipeline -c pipeline.yaml -p hello-world
jobs:
  job job-hello-world has been added:
    name: job-hello-world
    public: true
    plan:
    - task: hello-world
      config:
        platform: linux
        image_resource:
          type: docker-image
          source:
            repository: busybox
        run:
          path: echo
          args:
          - hello world
          dir: ""
    
apply configuration? [yN]: y
pipeline created!
you can view your pipeline here: http://192.168.100.4:8080/teams/main/pipelines/hello-world

the pipeline is currently paused. to unpause, either:
  - run the unpause-pipeline command
  - click play next to the pipeline in the web ui


$ fly -t eexpert unpause-pipelin -p hello-world
$ fly -t eexpert trigger-job -j hello-world/job-hello-world

```

Now checkout your browser `http://192.168.100.4:8080/teams/main/` you should see you have triggered the job inside the pipeline.
