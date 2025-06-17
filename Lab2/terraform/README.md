# NT548-lab2-group14-Terraform-GithubActions
NT548-lab2-group9-Terraform-GithubActions

Members of group 14:
| MSSV | FullName | Email |
|-------------|-----------------------|---------------------------------|
| 21522094 | Nguyễn Huy Hoàng | 21522094@gm.uit.edu.vn |
| 21522701 |    Hồ Minh Trí   | 21522701@gm.uit.edu.vn |


## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.46 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.46 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../ | n/a |
