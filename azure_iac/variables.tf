variable client_id {}
variable client_secret {}
variable ssh_public_key {}

variable environment {
    default = "dev"
}

variable location {
    default = "westeurope"
}

variable node_count {
  default = 2
}



variable dns_prefix {
  default = "k8stest"
}

variable cluster_name {
  default = "k8stest"
}

variable resource_group {
  default = "kubernetes"
}

# # to create client_id and client_secret
# - login to azure from console -> az login
# - run -> az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>"
# -- save all created credentails somwhere secure
# -- appId -> client_id
# -- password -> client_secret

# # to create ssh_public_key
# - run -> ssh-keygen -m PEM -t rsa -b 4096 (on Windows run command in GitBash)

# # nessesary terraform plugins for azure pipelines
# - https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks
# - https://marketplace.visualstudio.com/items?itemName=charleszipp.azure-pipelines-tasks-terraform

# # 3 connect to K8C
# - run -> az aks get-credentials --name <K8C_name> --resource-group <resource_group_name>

# https://stackoverflow.com/questions/61171623/azure-devops-why-is-my-subscription-not-shown-when-creating-a-new-service-conne/61227239#61227239
# https://jhooq.com/terraform-conidtional-check-failed/