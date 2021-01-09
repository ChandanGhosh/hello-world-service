# hello-world-service
Explorin flux 

# Pre-reqs
* fluxctl
* kubectl
* KIND/minikube cluster

---------------------------------------------------------------------------------------------------

# Add FluxCD repository to Helm repos:
```
helm repo add fluxcd https://charts.fluxcd.io
```

# Create the fluxcd namespace:
```
kubectl create ns fluxcd
```

# Install Flux by specifying your github/gitlab (replace fluxcd with your GitHub username):

```
helm upgrade -i flux fluxcd/flux --wait \
--namespace fluxcd \
--set git.url=git@github.com:chandanghosh/hello-world-service
```

# Install the HelmRelease Kubernetes custom resource definition:

```
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/crds.yaml
```

# Add this to the "deploy keys" section of the github repo so that the flux container is trusted. "Allow write access" is optional if you want the flux agent to make changes to the repo.



# Install Flux Helm Operator with Helm v3 support:
```
helm upgrade -i helm-operator fluxcd/helm-operator --wait \
--namespace fluxcd \
--set git.ssh.secretName=flux-git-deploy \
--set helm.versions=v3
```

# At startup, Flux generates a SSH key and logs the public key. Find the public key with:
```
fluxctl identity --k8s-fwd-ns fluxcd
```

# Or if you don't have fluxctl installed you can grab the public key from the flux deployment logs

```
kubectl -n fluxcd logs deployment/flux | grep identity.pub | cut -d '"' -f2
```

# Now add a chart repo for your deployment
```
helm repo add hello-world-service https://chandanghosh.github.io/hello-world-service/
```

# Now as soon as any changes published to HelmRelease yaml file under releases folder in the git repo, the flux container will pull the changes and hand it over to HelmOperator.

# As Helm Operator sees that this is a "HelmRelease" type deployment, it immediately deploys the chart and create a helm deployment for release management. 
You can ensure that flux has synced the latest commit from git by:
```
fluxctl sync --k8s-fwd-ns fluxcd
```

# Check the Helmrelease

```
kubectl get helmrelease -A

```
