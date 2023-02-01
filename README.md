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
After this command enter your AWS Credentials:
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
__Note:__: Use the same region for bucket and cluster.
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