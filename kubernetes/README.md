# Spring PetClinic Kubernetes Deployment

Creating namespace:

```bash
kubectl create -f ./petclinic.namespace.yml
```

Applying deployment:

```bash
kubectl apply -f ./petclinic.deployment.yml
```

Executing service:

```bash
kubectl apply -f ./petclinic.service.yml
```

Purge everything:

```bash
kubectl delete deploy petclinic -n petclinic
kubectl delete svc petclinic-service -n petclinic
kubectl delete namespace petclinic
```
