# Deployment Instructions

1. Run main.tf file to provision IaC on AWS

2. Once IaC is provisioned, login to the AWS console, from there login to provisioned cluster, commands:
`aws configure`
`aws eks --region=<region_name> update-kubeconfig --name=<cluster_name>`
`aws eks list-clusters`

3. Pull and deploy the image on to the cluster using deployment.yaml file
`kubectl apply -f deployment.yaml`

4. DevOps CI/CD pipeline
- https://learn.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml#service-account-option

# Kubernetes Cluster Commands
- `kubectl get serviceAccounts`
- `kubectl get namespace`
- `kubectl get events`
- `kubectl get events --sort-by=.metadata.creationTimestamp`
- `kubectl get pods`
- `kubectl get pods -o wide`
- `kubectl explain pods`
- `kubectl describe pod <pod_name>`
- `kubectl delete pods <pod_name>`
- `kubectl logs -f <pod_name>`
- `kubectl get replicaset`
- `kubectl explain replicaset`
- `kubectl get deployment`
- `kubectl get service`
- `kubectl get componentstatuses`
- `kubectl get all -o wide`
- delete all deployment, services, replica sets for app
-- `kubectl delete all -l app=my-website`
- deploy with yaml
-- `kubectl apply -f deployment.yaml`
- check the differences between running config against yaml file
-- `kubectl diff -f deployment.yaml`
- helpfull comands
- `kubectl get pods --all-namespaces` -> shows all pods associated with system and running app
- `kubectl get pods --all-namespaces -l app=my-website` -> shows all pods associated with running app
- `kubectl get services --all-namespaces --sort-by=spec.type`
- `kubectl get services --all-namespaces --sort-by=metadata.name`
- `kubectl cluster-info`
- `kubectl cluster-info dump`
- `kubectl top node`
- `kubectl top pod`