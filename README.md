# syslogng-docker

This is a sample implementation of syslog-ng PE in a Docker container. The default image is based off RHEL 9 UBI and includes [additional drivers](https://github.com/danelder/syslog-ng-drivers). To configure an Azure DevOps environment for building this, the following articles are useful:

* [Quickstart: Build a container image to deploy apps using Azure Pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/containers/build-image?view=azure-devops)
* [Use Azure Key Vault secrets in Azure Pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/release/key-vault-in-own-project?view=azure-devops&tabs=portal)
* [Use Azure Key Vault secrets in your Pipeline](https://learn.microsoft.com/en-us/azure/devops/pipelines/release/azure-key-vault?view=azure-devops&tabs=classic)
* [Store a multi-line secret in Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/secrets/multiline-secrets)
* [Use personal access tokens](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows)
* [Register an agent using device code flow](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/device-code-flow-agent-registration?view=azure-devops)
* [Azure Pipeline Docker@2 - Docker v2 task](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/docker-v2?view=azure-pipelines&tabs=yaml)
* [Azure Create a Docker service connection](https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/containers/push-image?view=azure-devops&tabs=azure#create-a-docker-service-connection)
* [Azure Red Hat OpenShift](https://azure.microsoft.com/en-us/products/openshift/)
* [OpenShift Extension for Azure DevOps Pipeline](https://medium.com/@voonck/openshift-extension-for-azure-devops-pipeline-b2049e3b519c)