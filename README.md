Please read the `README` file in the roor directory and inside each directory there is a `README` file explains what is every directory about.

The hierarchy here is as follow:

- concourse: this is a vagrant file with a basic concourse pipeline once you start `Vagrantfile` it uses one of `vagrant` images to setupn everything you would be able to start managing `concourse` straight using `fly` cli tool


- jenkins: this directory sets up `jenkins` server laveraging `Vagrantfile` and `ansible` 

- minikune: this directory explains steps to start a `minikube` and to deploy a `go` app written and packed into a `docker` image and aimed to deploy it to `minikube` using `helm`. the application is packaged as a `helm-chart` and all images are pushed to my personal public docker hub repo 



