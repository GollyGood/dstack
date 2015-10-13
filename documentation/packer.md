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
