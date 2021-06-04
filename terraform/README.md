
# Terraform

## Prerequisites

* install terraform version v0.15.4
* Verify ```terraform -version```

## Commands

* Initializing provider plugins: ``` terraform init ```
* Validate file: ``` terraform validate ```
* Review resources that you will create: ``` terraform plan ```
* Create infrastructure (virtual machines): 
``` 
 terraform apply -var user_name=Richard.Severich -var user_password=secretpassword 
```
* destroy infrastructure (virtual machines): 
``` 
 terraform destroy -var user_name=Richard.Severich -var user_password=secretpassword
```


## Sources

Terraform docs

* https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs

MobaXterm key generator (Public and Private)

* https://ubccr.freshdesk.com/support/solutions/articles/13000034093-using-ssh-keys-with-mobaxterm-windows-