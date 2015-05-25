Getting started
===============

This document covers requirements and installation for typical users of dStack
go to [configuration](configuration.md) for instructions on configuring dStack
for use, if it has not been setup already.

Requirements
------------

* Ruby >= 2.1.1
* Vagrant >= 1.6.3
* nfs
  * Ubuntu
    * Will need to be [installed](https://help.ubuntu.com/lts/serverguide/network-file-system.html) if using nfs.
    * Will also need to either configure your firewall for NFS or turn of your firewall if enabled. We are current looking to see what we can do about this on this [issue](https://github.com/grndlvl/dstack/issues/10).
    * Cannot be ran in an encrypted home directory or sharing directories in an encrypted home directory. Entire disk encryption is fine.
  * MacOSX - Already contains a working version of nfs.

**Windows is not supported.**

Installation
------------

1. Install VirtualBox (>= 4.3)

   Download [VirtualBox](https://www.virtualbox.org/manual/ch02.html)
   and install per its [installation instructions](https://www.virtualbox.org/manual/ch02.html)
   for your platform.

2. Install Vagrant (>= 1.6.3)

   Install per Vagrant's [installation guide](https://docs.vagrantup.com/v2/installation/index.html).

3. Install the Vagrant non-secure SSH key

   This may be done one or two ways.

      1) From within the root of this project run `make install`.

   or

      2) Manually create a symlink to the key

      $`ln -s ~/.vagrant.d/insecure_private_key ~/.ssh/vagrant_insecure_private_key`

      $`chmod 600 ~/.ssh/vagrant_insecure_private_key`

      and add the following to your SSH config `~/.ssh/config`. If there is not
      an SSH config file already, created it.

      ```
      Host *.local
        IdentityFile ~/.ssh/vagrant_insecure_private_key
        User vagrant
      ```

5. Run it!

   Run the $`vagrant up` command from the dStack root directory. Then wait...
   The first time this command runs it will need to download the base box.
   After the base box is downloaded it will begin to setup the virtual machine.
   You will need to type in your root password to allow for NFS to setup your
   shared directories. If the up fails be sure to check that you have your
   firewall configured to allow NFS or disabled. See [requirements](#requirements)
   for additional information.

Editing files
---------------------------

Since the development directories are shared to the guest machine you may edit
the files like you would any other file on your machine.

Accessing the guest machine
---------------------------

Use the $`vagrant ssh` command from the dStack root directory to ssh into
the guest machine.
