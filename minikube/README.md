# task:

Write a simple hello world application in either of these languages: Python, Ruby, Go. Build the application within a Docker container and then load balance the application within a mini kube.


Solution:
==========
This deployment is using minikube and helm, so please go through the `README` file before attempting to deply



Deployment
-----------
the `Dockerfile` in this repo has been built and pushed to my personal public repo in `hub.docker.com` which includes the simple app the image is being used in the deployment below

- I am starting minikube with virtualbox, with kubernetes `v1.11.0` as kube-proxy timed out when starting with `v1.10.0` with minikube release `v0.30.0` 

- If you want to change the VM driver add the appropriate `--vm-driver=xxx` flag to `minikube start`. Minikube supports
the following drivers:

* virtualbox
* vmwarefusion
* kvm2 ([driver installation](https://git.k8s.io/minikube/docs/drivers.md#kvm2-driver))
* kvm ([driver installation](https://git.k8s.io/minikube/docs/drivers.md#kvm-driver))
* hyperkit ([driver installation](https://git.k8s.io/minikube/docs/drivers.md#hyperkit-driver))
* xhyve ([driver installation](https://git.k8s.io/minikube/docs/drivers.md#xhyve-driver)) (deprecated)

Minikube will also create a "minikube" context, and set it to default in kubectl.
To switch back to this context later, run this command: `kubectl config use-context minikube`.



minikube
----------
```
cd ./eq-exp/minikube
```

```shell
$ minikube start --kubernetes-version v1.11.0
Starting local Kubernetes v1.11.0 cluster...
Starting VM...
Getting VM IP address...
Moving files into cluster...
Downloading kubeadm v1.11.0
Downloading kubelet v1.11.0
Finished Downloading kubeadm v1.11.0
Finished Downloading kubelet v1.11.0
Setting up certs...
Connecting to cluster...
Setting up kubeconfig...
Starting cluster components...
Kubectl is now configured to use the cluster.
Loading cached images from config file.


$ kubectl cluster-info
Kubernetes master is running at https://192.168.99.100:8443
CoreDNS is running at https://192.168.99.100:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

- Notice this IP of the master node `192.168.99.100`

- Download `helm` from https://github.com/helm/helm, follow instructions in `README.md` in helm repo on how to install helm binary

Now lets deploy tiller
```
$ helm init
$HELM_HOME has been configured at /Users/abdel/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
To prevent this, run `helm init` with the --tiller-tls-verify flag.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!



$ helm version
Client: &version.Version{SemVer:"v2.10.0", GitCommit:"9ad53aac42165a5fadc6c87be0dea6b115f93090", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.10.0", GitCommit:"9ad53aac42165a5fadc6c87be0dea6b115f93090", GitTreeState:"clean"}
```

Lets create a separate namespace for our service and deploy the application using the helm chart 

```
$ kubectl create ns eqex

$ kubectl get ns
NAME          STATUS    AGE
default       Active    11m
eqex          Active    20s
kube-public   Active    11m
kube-system   Active    11m


$ helm install -n eqex ./helm-chart --namespace eqex

NAME:   eqex
LAST DEPLOYED: Sun Nov 11 22:50:45 2018
NAMESPACE: eqex
STATUS: DEPLOYED

RESOURCES:
==> v1/Service
NAME         TYPE      CLUSTER-IP      EXTERNAL-IP  PORT(S)         AGE
eqex-go-k8s  NodePort  10.111.107.246  <none>       3000:30296/TCP  0s

==> v1beta1/Deployment
NAME         DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
eqex-go-k8s  1        1        1           0          0s

==> v1/Pod(related)
NAME                          READY  STATUS             RESTARTS  AGE
eqex-go-k8s-5d94c99856-p227m  0/1    ContainerCreating  0         0s


NOTES:
1. Get the application URL by running these commands:
  export NODE_PORT=$(kubectl get --namespace eqex -o jsonpath="{.spec.ports[0].nodePort}" services eqex-go-k8s)
  export NODE_IP=$(kubectl get nodes --namespace eqex -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT/projects


> to get a list of all deployed charts
$ helm list
NAME	REVISION	UPDATED                 	STATUS  	CHART       	APP VERSION	NAMESPACE
eqex	2       	Sun Nov 11 22:51:48 2018	DEPLOYED	go-k8s-0.1.0	           	eqex   


$ kubectl get svc -n eqex
NAME          TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
eqex-go-k8s   NodePort   10.111.107.246   <none>        3000:30296/TCP   22s


$ kubectl get pod -n eqex
NAME                           READY     STATUS    RESTARTS   AGE
eqex-go-k8s-5d94c99856-jkmfm   1/1       Running   0          1m
eqex-go-k8s-5d94c99856-p227m   1/1       Running   0          2m

```


From that `nodePort` in our case is `30296` you access your application with 
```
$ curl 192.168.99.100:30296 
``` 
or from your browser `192.168.99.100:30296`
