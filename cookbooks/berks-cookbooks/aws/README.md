# aws Cookbook
[![Build Status](https://travis-ci.org/chef-cookbooks/aws.svg?branch=master)](https://travis-ci.org/chef-cookbooks/aws) [![Cookbook Version](https://img.shields.io/cookbook/v/aws.svg)](https://supermarket.chef.io/cookbooks/aws)

This cookbook provides libraries, resources and providers to configure and manage Amazon Web Services components and offerings with the EC2 API. Currently supported resources:
- EBS Volumes (`ebs_volume`)
- EBS Raid (`ebs_raid`)
- Elastic IPs (`elastic_ip`)
- Elastic Load Balancer (`elastic_lb`)
- AWS Resource Tags (`resource_tag`)
- Secondary IPs (`secondary_ip`)
- AWS Cloudwatch Instance Monitoring (`aws_instance_monitoring`)

Unsupported AWS resources that have other cookbooks include but are not limited to:
- [Route53](https://supermarket.chef.io/cookbooks/route53)
- [aws_security](https://supermarket.chef.io/cookbooks/aws_security)

## Requirements
### Platforms
- Any platform supported by Chef and the AWS-SDK

### Chef
- Chef 11+

### Cookbooks
- Ohai

## Credentials
In order to manage AWS components, authentication credentials need to be available to the node. There are 2 way to handle this:
1. explicitly pass credentials parameter to the resource
2. let the resource pick up credentials from the IAM role assigned to the instance

### Using resource parameters
In order to pass the credentials to the resource, credentials must be available to the node. There are a number of ways to handle this, such as node attributes applied to the node or via Chef roles/environments.

We recommend storing these in an encrypted databag, and loading them in the recipe where the resources are used.

Example Data Bag:

```json
% knife data bag show aws main
{
  "id": "main",
  "aws_access_key_id": "YOUR_ACCESS_KEY",
  "aws_secret_access_key": "YOUR_SECRET_ACCESS_KEY",
  "aws_session_token": "YOUR_SESSION_TOKEN"
}
```

This can be loaded in a recipe with:

```ruby
aws = data_bag_item('aws', 'main')
```

And to access the values:

```ruby
aws['aws_access_key_id']
aws['aws_secret_access_key']
aws['aws_session_token']
```

We'll look at specific usage below.

### Using IAM instance role
If your instance has an IAM role, then the credentials can be automatically resolved by the cookbook using Amazon instance metadata API.

You can then omit the resource parameters `aws_secret_access_key` and `aws_access_key`.

Of course, the instance role must have the required policies. Here is a sample policy for EBS volume management:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateVolume",
        "ec2:ModifyVolumeAttribute",
        "ec2:DescribeVolumeAttribute",
        "ec2:DescribeVolumeStatus",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume",
        "ec2:EnableVolumeIO"
      ],
      "Sid": "Stmt1381536011000",
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    }
  ]
}
```

For resource tags:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:CreateTags",
        "ec2:DescribeTags"
      ],
      "Sid": "Stmt1381536708000",
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    }
  ]
}
```

## Recipes
### default.rb
The default recipe installs the `aws-sdk` Ruby Gem, which this cookbook requires in order to work with the EC2 API. Make sure that the aws recipe is in the node or role `run_list` before any resources from this cookbook are used.

```json
"run_list": [
  "recipe[aws]"
]
```

The `gem_package` is created as a Ruby Object and thus installed during the Compile Phase of the Chef run.

### ec2_hints.rb
This recipe is used to setup the ec2 hints for ohai in the case that an instance is not created using knife-ec2.

## Libraries
The cookbook has a library module, `Opscode::AWS::Ec2`, which can be included where necessary:

```ruby
include Opscode::Aws::Ec2
```

This is needed in any providers in the cookbook. Along with some helper methods used in the providers, it sets up a class variable, `ec2` that is used along with the access and secret access keys

## Resources and Providers
This cookbook provides two resources and corresponding providers.

### ebs_volume.rb
Manage Elastic Block Store (EBS) volumes with this resource.

#### Actions:
- `create` - create a new volume.
- `attach` - attach the specified volume.
- `detach` - detach the specified volume.
- `snapshot` - create a snapshot of the volume.
- `prune` - prune snapshots.

#### Properties:
- `aws_secret_access_key`, `aws_access_key` and optionally `aws_session_token` - required, unless using IAM roles for authentication.
- `size` - size of the volume in gigabytes.
- `snapshot_id` - snapshot to build EBS volume from.
- `most_recent_snapshot` - use the most recent snapshot when creating a volume from an existing volume (defaults to false)
- `availability_zone` - EC2 region, and is normally automatically detected.
- `device` - local block device to attach the volume to, e.g. `/dev/sdi` but no default value, required.
- `volume_id` - specify an ID to attach, cannot be used with action `:create` because AWS assigns new volume IDs
- `timeout` - connection timeout for EC2 API.
- `snapshots_to_keep` - used with action `:prune` for number of snapshots to maintain.
- `description` - used to set the description of an EBS snapshot
- `volume_type` - "standard", "io1", or "gp2" ("standard" is magnetic, "io1" is provisioned SSD, "gp2" is general purpose SSD)
- `piops` - number of Provisioned IOPS to provision, must be >= 100
- `existing_raid` - whether or not to assume the raid was previously assembled on existing volumes (default no)
- `encrypted` - specify if the EBS should be encrypted
- `kms_key_id` - the full ARN of the AWS Key Management Service (AWS KMS) master key to use when creating the encrypted volume (defaults to master key if not specified)
- `delete_on_termination` - Boolean value to control whether or not the volume should be deleted when the instance it's attached to is terminated (defaults to nil).  Only applies to `:attach` action.

### ebs_raid.rb
Manage Elastic Block Store (EBS) raid devices with this resource.

#### Actions:
- `auto_attach` - create / mount raid array

#### Properties:
- `aws_secret_access_key`, `aws_access_key` and optionally `aws_session_token` - required, unless using IAM roles for authentication.
- `mount_point` - where to mount the RAID volume
- `mount_point_owner` - the owner of the mount point (default root)
- `mount_point_group` - the group of the mount point (default root)
- `mount_point_mode` - the file mode of the mount point (default 00755)
- `disk_count` - number of EBS volumes to raid
- `disk_size` - size of EBS volumes to raid
- `level` - RAID level (default 10)
- `filesystem` - filesystem to format raid array (default ext4)
- `filesystem_options` - String of options to mount the filesystem with (default rw,noatime,nobootwait)
- `snapshots` - array of EBS snapshots to restore. Snapshots must be taken using an ec2 consistent snapshot tool, and tagged with a number that indicates how many devices are in the array being backed up (e.g. "Logs Backup [0-4]" for a four-volume raid array snapshot)
- `disk_type` - "standard", "io1", or "gp2" ("standard" is magnetic, "io1" is provisioned iops SSD, "gp2" is general purpose SSD)
- `disk_piops` - number of Provisioned IOPS to provision per disk, must be > 100
- `disk_encrypted` - specify if the EBS volumes should be encrypted
- `disk_kms_key_id` - the full ARN of the AWS Key Management Service (AWS KMS) master key to use when creating the encrypted volumes (defaults to master key if not specified)

### elastic_ip.rb
#### Actions:
- `associate` - associate the IP.
- `disassociate` - disassociate the IP.

#### Properties:
- `aws_secret_access_key`, `aws_access_key` and optionally `aws_session_token` - passed to `Opscode::AWS:Ec2` to authenticate, required, unless using IAM roles for authentication.
- `ip` - the IP address.
- `timeout` - connection timeout for EC2 API.

### elastic_lb.rb
#### Actions:
- `register` - Add this instance to the LB
- `deregister` - Remove this instance from the LB

#### Properties:
- `aws_secret_access_key`, `aws_access_key` and optionally `aws_session_token` - passed to `Opscode::AWS:Ec2` to authenticate, required, unless using IAM roles for authentication.
- `name` - the name of the LB, required.

### resource_tag.rb
#### Actions:
- `add` - Add tags to a resource.
- `update` - Add or modify existing tags on a resource -- this is the default action.
- `remove` - Remove tags from a resource, but only if the specified values match the existing ones.
- `force_remove` - Remove tags from a resource, regardless of their values.

#### Properties:
- `aws_secret_access_key`, `aws_access_key` and optionally `aws_session_token` - passed to `Opscode::AWS:Ec2` to authenticate, required, unless using IAM roles for authentication.
- `tags` - a hash of key value pairs to be used as resource tags, (e.g. `{ "Name" => "foo", "Environment" => node.chef_environment }`,) required.
- `resource_id` - resources whose tags will be modified. The value may be a single ID as a string or multiple IDs in an array. If no
- `resource_id` is specified the name attribute will be used.

### instance_monitoring.rb
#### Actions:
- `enable` - Enable detailed CloudWatch monitoring for this instance (Default).
- `disable` - Disable detailed CloudWatch monitoring for this instance.

#### Properties:
- `aws_secret_access_key`, `aws_access_key` and optionally `aws_session_token` - passed to `Opscode::AWS:Ec2` to authenticate, required, unless using IAM roles for authentication.

### secondary_ip.rb
This feature is available only to instances in EC2-VPC. It allows you to assign
multiple private IP addresses to a network interface.

#### Actions:

- `assign` - Assign a private IP to the instance.
- `unassign` - Unassign a private IP from the instance.

#### Properties:

- `aws_secret_access_key`, `aws_access_key` and optionally `aws_session_token` - passed to `Opscode::AWS:Ec2` to authenticate, required, unless using IAM roles for authentication.
- `ip` - the private IP address. If none is given on assignment, will assign a random IP in the subnet.
- `interface` - the network interface to assign the IP to. If none is given, uses the default interface.
- `timeout` - connection timeout for EC2 API.

## Usage
The following examples assume that the recommended data bag item has been created and that the following has been included at the top of the recipe where they are used.

```ruby
include_recipe 'aws'
aws = data_bag_item('aws', 'main')
```

### aws_ebs_volume
The resource only handles manipulating the EBS volume, additional resources need to be created in the recipe to manage the attached volume as a filesystem or logical volume.

```ruby
aws_ebs_volume 'db_ebs_volume' do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  size 50
  device '/dev/sdi'
  action [:create, :attach]
end
```

This will create a 50G volume, attach it to the instance as `/dev/sdi`.

```ruby
aws_ebs_volume 'db_ebs_volume_from_snapshot' do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  size 50
  device '/dev/sdi'
  snapshot_id 'snap-ABCDEFGH'
  action [:create, :attach]
end
```

This will create a new 50G volume from the snapshot ID provided and attach it as `/dev/sdi`.

### aws_elastic_ip
The `elastic_ip` resource provider does not support allocating new IPs. This must be done before running a recipe that uses the resource. After allocating a new Elastic IP, we recommend storing it in a databag and loading the item in the recipe.

Databag structure:

```json
% knife data bag show aws eip_load_balancer_production
{
  "id": "eip_load_balancer_production",
  "public_ip": "YOUR_ALLOCATED_IP"
}
```

Then to set up the Elastic IP on a system:

```ruby
ip_info = data_bag_item('aws', 'eip_load_balancer_production')

aws_elastic_ip 'eip_load_balancer_production' do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  ip ip_info['public_ip']
  action :associate
end
```

This will use the loaded `aws` and `ip_info` databags to pass the required values into the resource to configure. Note that when associating an Elastic IP to an instance, connectivity to the instance will be lost because the public IP address is changed. You will need to reconnect to the instance with the new IP.

You can also store this in a role as an attribute or assign to the node directly, if preferred.

### aws_elastic_lb
`elastic_lb` functions similarly to `elastic_ip`. Make sure that you've created the ELB and enabled your instances' availability zones prior to using this provider.

For example, to register the node in the 'QA' ELB:

```ruby
aws_elastic_lb 'elb_qa' do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  name 'QA'
  action :register
end
```

### aws_resource_tag
`resource_tag` can be used to manipulate the tags assigned to one or more AWS resources, i.e. ec2 instances, ebs volumes or ebs volume snapshots.

Assigning tags to a node to reflect its role and environment:

```ruby
aws_resource_tag node['ec2']['instance_id'] do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  tags('Name' => 'www.example.com app server',
       'Environment' => node.chef_environment)
  action :update
end
```

Assigning a set of tags to multiple resources, e.g. ebs volumes in a disk set:

```ruby
aws_resource_tag 'my awesome raid set' do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  resource_id ['vol-d0518cb2', 'vol-fad31a9a', 'vol-fb106a9f', 'vol-74ed3b14']
  tags('Name' => 'My awesome RAID disk set',
       'Environment' => node.chef_environment)
end
```

```ruby
aws_resource_tag 'db_ebs_volume' do
  resource_id lazy { node['aws']['ebs_volume']['db_ebs_volume']['volume_id'] }
  tags ({ 'Service' => 'Frontend' })
end
```

### aws_s3_file
`s3_file` can be used to download a file from s3 that requires aws authorization.  This is a wrapper around `remote_file` and supports the same resource attributes as `remote_file`.

```ruby
aws_s3_file '/tmp/foo' do
  bucket 'i_haz_an_s3_buckit'
  remote_path 'path/in/s3/bukket/to/foo'
  aws_access_key_id aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  region 'us-west-1'
end
```

## aws_instance_monitoring
Allows detailed CloudWatch monitoring to be enabled for the current instance.

```ruby
aws_instance_monitoring "enable detailed monitoring"
```

## aws_secondary_ip
The `secondary_ip` resource provider allows one to assign/unassign multiple private secondary IPs on an instance in EC2-VPC. The number of secondary IP addresses that you can assign to an instance varies by instance type. If no ip address is provided on assign, a random one from within the subnet will be assigned. If no interface is provided, the default interface (which is pulled from Ohai) will be used.

```ruby
aws_secondary_ip "assign_additional_ip" do
  aws_access_key aws['aws_access_key_id']
  aws_secret_access_key aws['aws_secret_access_key']
  ip ip_info['private_ip']
  interface 'eth0'
  action :assign
end
```

## License and Authors
- Author:: Chris Walters ([cw@chef.io](mailto:cw@chef.io))
- Author:: AJ Christensen ([aj@chef.io](mailto:aj@chef.io))
- Author:: Justin Huff ([jjhuff@mspin.net](mailto:jjhuff@mspin.net))

Copyright 2009-2015, Chef Software, Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
