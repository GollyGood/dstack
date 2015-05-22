Packer
======

[Packer](https://www.packer.io/) is used to create new boxes. All of dStack's
boxes are created and maintained via Packer.

For information on creating your own box checkout the [Packer Documentation](https://www.packer.io/docs).

To create a box based on a template use the following command:

$`packer build -only=virtualbox-iso [template-name].json`
