Configuration
=============

The configuration file is a single YAML file that dictates Vagrant box settings
as well as chef recipe attributes. Any settings within this configuration file
will take precedence over default and normal recipe attributes.

* [vagrant](#vagrant)
* [vlamp](#vlamp)
* [utils](#utils)
* [chef](#chef)

vagrant
-------

These settings correspond to Vagrant and are used to configure the virtual guest
machine.

### Common settings
* `hostname`

    **default:** `'default'`

    The hostname to be used for the guest machine.

* `memory`

    The memory in MB to be allocated for the guest machine.

    **default:** `2048`

* `networks`

    All network adapters for the guest machine. By default a private network is
    created for use of NFS. Due to issues with dhcp on Vagrant+VirtualBox with
    Ubuntu 12.04 a static ip address is required. We recommend keeping track of
    assigned ip addresses via a spreadsheet as to prevent collisions between
    multiple projects. We hope to resolve this in future versions [#47].

    To declare network adapters, an array of settings will need to be supplied
    where the key is the type of adapter and its values are an associative array
    of settings to be passed to Vagrant's `config.vm.network`.

    **default:**
    ```
      networks:
        private_network:
          ip: 192.168.50.4
    ```

### Advanced settings

* `tld`

   The top level domain for the sites configured for the guest machine.
   *Note: This is used by the sites dStack handler to populate the
   <full-domain> token. It is important to note that this should not be changed
   if Avahi is being used as currently the default is only supported.*

    **default:** `'local'`

* `box`

   The Vagrant ready box file to use for the guest machine. It is recommended
   to use the provided dStack boxes, however, you may use any Vagrant box file
   or even create your own.

    **default:** `'dstack-ubuntu-12.04'`

* `synced_folders`

    Additional synced directories that should be synced between the host and
    guest machine. This is supplied as an associative array where the key is
    the host machines directory and the value is the directory on the guest
    machine.

    By default this is blank, however, some directories, such as, `assets` and
    `docroots` are automatically set up as synced folders.

    **default:** No default supplied.

    **example:**
    ```
    HOST_DIRECTORY: GUEST_DIRECTORY
    ANOTHER_HOST_DIRECTORY: ANOTHER_GUEST_DIRECTORY
    ```

* `synced_folders_type`

     The type of synchronization to employ for all synced folders. Options
     include nfs, rsync, smb(untested), and the default virtual box
     sync(set to `''`).

     **default:** `'nfs'`

* `assets_folder`

     The  assets folder contains things like SSL certs that are to be used
     within the guest machine. This directory will automatically be synced
     between the host and guest machine.

     **default:**
     ```
     host_directory: 'assets'
     guest_directory: '/home/vagrant/assets'
     ```

* `forward_agent`

    Determines if all ssh connections should forward the user's ssh agent for
    all ssh connections.

    **default:** `true`

vlamp
-------

utils
-------

chef
-------
