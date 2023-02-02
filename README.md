# Preparatory stage

### Installation:
- __[Git](https://git-scm.com/downloads)__
- __[Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)__
- __[Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)__
- __[AWS-CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)__
- __Kubernetes__:
    - [Install kubectl on Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
    - [Install kubectl on macOS](https://git-scm.com/downloads)
    - [Install kubectl on Windows](https://git-scm.com/downloads)
- __[Helm](https://helm.sh/docs/intro/install/)__
- __[Velero](https://velero.io/docs/v1.8/basic-install/)__

---

### Requirements:
- Git: latest
- Terraform: v1.3.7
- Terragrunt: v0.42.8
- AWS-CLI: v1.27.37
- Kubernetes: v1.25.2
- Helm: v3.10.2
- Velero: v1.9.5

---
### Clone repo:
```
$ git clone https://github.com/MykhailoPasiechnyk/jenkins-velero-eks-terragrunt.git
$ cd jenkins-velero-eks-terragrunt
```
---

### Set credentials for AWS CLI:
*__Note:__ After this command enter your AWS Credentials.*

```
$ aws configure
```
---

### Set credentials for Terraform:
#### Windows:
```
$ set AWS_ACCESS_KEY_ID="aws_access_key_id"
$ set AWS_SECRET_ACCESS_KEY="aws_secret_access_key"
```

#### Linux:
```
$ export AWS_ACCESS_KEY_ID="aws_access_key_id"
$ export AWS_SECRET_ACCESS_KEY="aws_secret_access_key"
```
---

### Create AWS S3 Bucket for Terraform state files:
```
$ aws s3api create-bucket --bucket $TF_STATE_BUCKET_NAME --region $TF_STATE_BUCKET_REGION
```
- __In ./terragrunt/terragrunt.hcl (line: 21) replace "test-terragrunt-state-bucket" to $TF_STATE_BUCKET_NAME__
- __In ./terragrunt/terragrunt.hcl (line: 22) replace "eu-central-1" to $BUCKET_REGION__

#### To remove the bucket use this command:
```
$ aws s3api delete-bucket --bucket $TF_STATE_BUCKET_NAME --region $TF_STATE_BUCKET_REGION
```
---
### Create AWS S3 Bucket for Velero backups:
*__Note:__: Use the same region for bucket and cluster.*

```
$ aws s3api create-bucket --bucket $VELERO_BUCKET_NAME --region $VELERO_BUCKET_REGION
```
- __In ./terragrunt/dev/eu-central-1/region.hcl (line: 5) replace "velero-backup-test" to $VELERO_BUCKET_NAME__

#### To remove the bucket use this command:
```
$ aws s3api delete-bucket --bucket $VELERO_BUCKET_NAME --region $VELERO_BUCKET_REGION
```
---

### Create AWS IAM user for Velero:
```
$ aws iam create-user --user-name velero
```
#### Create an access key for the user:
```
$ aws iam create-access-key --user-name velero
``` 
#### Create a Velero-specific credentials file (credentials-velero) in ./terragrunt/dev/eu-central-1/05-velero/ directory:
```
[default]
aws_access_key_id=<AWS_ACCESS_KEY_ID>
aws_secret_access_key=<AWS_SECRET_ACCESS_KEY>
```
*__Note__: Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY from previous step*

---
### Set 'user name' and 'password' for Jenkins admin user:
*In ./terragrunt/dev/eu-central-1/04-jenkins/terraform.tfvars*

```
jenkins_admin_user     = "user name"
jenkins_admin_password = "password"
```
---
# Run-All Resources
---
*In folder ./terragrunt/dev/:*

```
$ terragrunt run-all apply
```
---
## Update kubeconfig for cluster access:
```
$ aws eks update-kubeconfig --region eu-central-1 --name cluster
```
*__Note:__ You can change the cluster name in ./terragrunt/dev/eu-central-1/02-eks/terraform.tfvars*

---
## Get entrypoint to Jenkins:
```
$ kubectl get svc -n jenkins
```
---
# Velero:

## Create backup and restore your cluster:
*__Note:__ Backups and restores keeps in your S3 Velero Bucket*

1. Create backup your cluster:
*__Note:__ The name of backup must be unique.*

```
$ velero backup create 'backup name'
```
2. Create clean K8S Cluster with Velero and update kubeconfig.
3. Restore old cluster to new:
```
$ velero restore create --from-backup 'backup name'
```
## Get all backups:
```
$ velero backup get
```

## Get all restores:
```
$ velero restore get
```
---

# Clean up all resources:
*__Note:__ In ./terragrunt/dev/ folder:*

```
$ terragrunt run-all destroy
```
