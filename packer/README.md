Packer
======

[Packer](https://www.packer.io/) is used to create new boxes. All of dStack's
boxes are created and maintained via Packer.

For information on creating your own box checkout the [Packer Documentation](https://www.packer.io/docs).

To create a box based on a template use the following command:

$`packer build -only=virtualbox-iso [template-name].json`

## Supported guest operating systems

* Ubuntu 12.04

While, chef and many of the components we use will support other operating systems
there are a few that currently do not. We plan on adding CentOS and will
probably switching over to Debian eventually as the main.

## Self-serving Vagrant box file

1. Place box file on a publically available server so that it may be dowloaded.
   Be sure to include a version number in the file name.
2. Create a json file in the same directory named [box-name].json
3. Generate the checksum for the file using the following command

$`openssl sha1 [box-name]-[version].box`

4. Customize the below contents

```
{
    "name": "dstack-ubuntu-12.04",
    "description": "This box contains Ubuntu 12.04.5 LTS 64-bit.",
    "versions": [{
        "version": "0.1.0",
        "providers": [{
                "name": "virtualbox",
                "url": "http://devhumans.com/dstack/dstack_ubuntu-12.04_chef-11.16.4.box",
                "checksum_type": "sha1",
                "checksum": "c540f1092e8eb9918a7a9ee80fcd885494dc5d6e"
        }]
    },{
        "version": "0.1.1",
        "providers": [{
                "name": "virtualbox",
                "url": "http://devhumans.com/dstack/dstack-0.1.1_ubuntu-12.04_chef-11.16.4.box",
                "checksum_type": "sha1",
                "checksum": "5f355424ad8894d8002d7211d23777d2f63a9b36"
        }]
    }]
}
```
