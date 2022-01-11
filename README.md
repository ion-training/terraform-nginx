# terraform-nginx
terraform provision nginx/ubuntu on aws

# Topology
![](./screenshots/2022-01-11-21-58-29.png)

# How to use this repo
```
git clone git@github.com:ion-training/terraform-nginx.git && cd terraform-nginx
```

Add your AWS credentials as two environment variables:
```
export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY>
export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_KEY>
```
Terraform init
```
terraform init
```
Create resources
```
terraform apply -auto-approve
```

Variables that can be changed:
- region - defaults to eu-north-1a
- prefix_name - defaults to "ion" used to prefix tags

Use terraform output for instructions on how to connect with HTTP and SSH.
```
terraform output
```

# Sample output
```
$ terraform output
connect_SSH = "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@16.170.98.37"
connect_url = "http://ec2-16-170-98-37.eu-north-1.compute.amazonaws.com"
```

```
$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.web will be created
  + resource "aws_instance" "web" {
      + ami                                  = "ami-056bbd85327482a72"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "ion-ubuntu"
        }
      + tags_all                             = {
          + "Name" = "ion-ubuntu"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "1c3b3aad9fd17b70da655f8ce952ac9ee7ba370b"
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.gw will be created
  + resource "aws_internet_gateway" "gw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = (known after apply)
      + tags_all = (known after apply)
      + vpc_id   = (known after apply)
    }

  # aws_key_pair.ssh-key will be created
  + resource "aws_key_pair" "ssh-key" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = (known after apply)
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + public_key      = (known after apply)
      + tags            = (known after apply)
      + tags_all        = (known after apply)
    }

  # aws_route_table.route_table will be created
  + resource "aws_route_table" "route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = (known after apply)
      + tags_all         = (known after apply)
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.a will be created
  + resource "aws_route_table_association" "a" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.web-server will be created
  + resource "aws_security_group" "web-server" {
      + arn                    = (known after apply)
      + description            = "Allow inbound traffic"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Enter HTTP"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Enter SSH"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "web-server"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = (known after apply)
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.subnet_web will be created
  + resource "aws_subnet" "subnet_web" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = (known after apply)
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.0.1.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = (known after apply)
      + tags_all                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.vpc will be created
  + resource "aws_vpc" "vpc" {
      + arn                            = (known after apply)
      + cidr_block                     = "10.0.0.0/16"
      + default_network_acl_id         = (known after apply)
      + default_route_table_id         = (known after apply)
      + default_security_group_id      = (known after apply)
      + dhcp_options_id                = (known after apply)
      + enable_classiclink             = (known after apply)
      + enable_classiclink_dns_support = (known after apply)
      + enable_dns_hostnames           = true
      + enable_dns_support             = true
      + id                             = (known after apply)
      + instance_tenancy               = "default"
      + ipv6_association_id            = (known after apply)
      + ipv6_cidr_block                = (known after apply)
      + main_route_table_id            = (known after apply)
      + owner_id                       = (known after apply)
      + tags                           = (known after apply)
      + tags_all                       = (known after apply)
    }

  # local_file.ssh-key-file will be created
  + resource "local_file" "ssh-key-file" {
      + content              = (sensitive)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./artifacts/id_rsa.priv"
      + id                   = (known after apply)
    }

  # random_pet.suffix_name will be created
  + resource "random_pet" "suffix_name" {
      + id        = (known after apply)
      + length    = 1
      + separator = "-"
    }

  # tls_private_key.keys will be created
  + resource "tls_private_key" "keys" {
      + algorithm                  = "RSA"
      + ecdsa_curve                = "P224"
      + id                         = (known after apply)
      + private_key_pem            = (sensitive value)
      + public_key_fingerprint_md5 = (known after apply)
      + public_key_openssh         = (known after apply)
      + public_key_pem             = (known after apply)
      + rsa_bits                   = 2048
    }

Plan: 11 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + connect_SSH = (known after apply)
  + connect_url = (known after apply)
random_pet.suffix_name: Creating...
random_pet.suffix_name: Creation complete after 0s [id=bluejay]
tls_private_key.keys: Creating...
tls_private_key.keys: Creation complete after 0s [id=831ffab29e2899afa1981415c1959666b7e62846]
local_file.ssh-key-file: Creating...
local_file.ssh-key-file: Provisioning with 'local-exec'...
local_file.ssh-key-file (local-exec): Executing: ["/bin/sh" "-c" "chmod 400 ./artifacts/id_rsa.priv"]
local_file.ssh-key-file: Creation complete after 0s [id=8b8a1fd8fa1678ce98be75f1551721eb202a1c3d]
aws_key_pair.ssh-key: Creating...
aws_vpc.vpc: Creating...
aws_key_pair.ssh-key: Creation complete after 1s [id=ion-ssh-key-bluejay]
aws_vpc.vpc: Still creating... [10s elapsed]
aws_vpc.vpc: Creation complete after 13s [id=vpc-0c58b20ec999fce10]
aws_internet_gateway.gw: Creating...
aws_subnet.subnet_web: Creating...
aws_security_group.web-server: Creating...
aws_subnet.subnet_web: Creation complete after 1s [id=subnet-0de26c8ae24a5e393]
aws_internet_gateway.gw: Creation complete after 1s [id=igw-0bf91027477343e7c]
aws_route_table.route_table: Creating...
aws_route_table.route_table: Creation complete after 2s [id=rtb-06f131f2a2f31b053]
aws_route_table_association.a: Creating...
aws_security_group.web-server: Creation complete after 3s [id=sg-07c94d49cec68ae50]
aws_instance.web: Creating...
aws_route_table_association.a: Creation complete after 0s [id=rtbassoc-0d597854f6ec9b65d]
aws_instance.web: Still creating... [10s elapsed]
aws_instance.web: Creation complete after 14s [id=i-099a22360339da349]

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

connect_SSH = "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@16.170.98.37"
connect_url = "http://ec2-16-170-98-37.eu-north-1.compute.amazonaws.com"
```
