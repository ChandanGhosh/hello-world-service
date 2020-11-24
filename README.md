# hello-world-service
Explorin flux 

# Pre-reqs
* fluxctl
* kubectl
* KIND cluster
* kubectl create namespace flux
* kubectl apply -f flux.yaml
* fluxctl identity --k8s-fwd-ns flux

Add the SSH key in "deploy keys" section in the repository settings

* Now the flux should run in background and poll to see if there is any changes in the repo and deploy to KIND/any K8S cluster automatically

fluxctl install \
--git-url=git@github.com:username/hello-world-service \
--git-user=username \
--git-email=emailid@email.com \
--git-path=namespaces,workloads \
--namespace=flux > flux.yaml
