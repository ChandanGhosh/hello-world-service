# hello-world-service
Explorin flux 

# Pre-reqs
* fluxctl
* kubectl
* KIND cluster
* kubectl create namespace flux
* kubectl apply -f flux.yaml
* fluxctl identity --k8s-fwd-ns flux

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

# Now create a chart for your deployment
```
helm create hello-world-service
```

# Once the chart folder is created, just change the image repository value no nginx version 1.14.2 in the values.yaml file.

# Then test the deployment first. Please note this is not the HelmRelease we want to achieve the GitOps with. We're just ensuring that our chart is valid and can be used for deployment.

```
helm upgrade -i hello-world-app hello-world-service
```
# Test the app

# Create chart archive after successfullky testing the app

```
make all
```

