Configuration
=============

To begin configuration, copy `example.config.yml` to `config.yml`. Alter the sections
relevant to your project.

For a run down of the minimum configuration check out the [vagrant](#vagrant) and
[vlamp](#vlamp) sections.

The configuration file is a single YAML file that dictates the Vagrant box settings
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

    **default:** `default`

    The hostname to be used for the guest machine.

* `memory`

    The memory in MB to be allocated for the guest machine.

    **default:** `2048`

* `networks`

    All network adapters for the guest machine. By default a private network is
    created for use of NFS. Due to issues with dhcp on Vagrant+VirtualBox with
    Ubuntu 12.04 a static ip address is required and must be unique between boxes
    if it is planned to have multiple machines running at the same time.
    We recommend keeping track of assigned ip addresses via a spreadsheet as to
    prevent collisions between multiple projects. We hope to resolve this in
    future versions [Get DHCP Working again #47](https://github.com/gollygood/dstack/issues/47).

    To declare network adapters, an array of settings will need to be supplied
    where the key is the type of adapter and its values are an associative array
    of settings to be passed to Vagrant's `config.vm.network`.

    **default:**
    ```
      networks:
        - private_network:
            ip: 192.168.50.4
    ```

### Advanced settings

* `tld`

   The top level domain for the sites configured for the guest machine.
   *Note: This is used by the sites dStack handler to populate the
   <full-domain> token. It is important to note that this should not be changed
   if Avahi is being used as currently the default is only supported.*

    **default:** `local`

* `box`

   The Vagrant ready box file to use for the guest machine. It is recommended
   to use the provided dStack boxes, however, you may use any Vagrant box file
   or even create your own.

    **default:** `dstack-ubuntu-12.04`

* `box_url`

   The Vagrant ready box url to use for fetching the guest box.

    **default:** `http://devhumans.com/dstack/dstack-ubuntu-12.04.json`

* `box_version`

    The version of the Vagrant box to use.

    **default:** `>= 0` (The most recent version.)

* `synced_folders_type_default`

  The default Vagrant synced folder type to use for all synced folders that does
  not specify one. Checkout Vagrant's documentation for [Synced folders](https://docs.vagrantup.com/v2/synced-folders/index.html).

  **default:** `rsync`

* `synced_folders`

    Additional synced directories that should be synced between the host and
    guest machine. This is supplied as an array of hashes where each hash contains
    the host machine's directory and the value is the directory on the guest
    machine. Optionally, the type of synced folder and additional options may
    be supplied. Type options include nfs, rsync, smb(untested), and the default
    virtual box sync(set to `''`).

    By default this is blank, however, some directories, such as, `assets` and
    `docroots` are automatically set up as synced folders.

    **example:**
    ```
    - host_directory: HOST_DIRECTORY
      guest_directory: GUEST_DIRECTORY
      options:
        rsync__exclude: files
    - host_directory: ANOTHER_HOST_DIRECTORY
      guest_directory: ANOTHER_GUEST_DIRECTORY
      options:
        type: nfs
        nfs_udp: false
    - host_directory: MORE_ASSETS_HOST_DIRECTORY
      guest_direcotry: MORE_ASSETS_GUEST_DIRECTORY
      options:
        type: ''
    ```

* `synced_folders_type`

     The type of synchronization to employ for all synced folders. Options
     include nfs, rsync, smb(untested), and the default virtual box
     sync(set to `''`).

     **default:** `nfs`

* `assets_folder`

     The  assets folder contains things like SSL certs that are to be used
     within the guest machine. This directory will automatically be synced
     between the host and guest machine.

     **default:**
     ```
     host_directory: assets
     guest_directory: /home/vagrant/assets
     ```

* `forward_agent`

    Determines if all ssh connections should forward the user's ssh agent for
    all ssh connections.

    **default:** `true`

vlamp
-------

 The vlamp configuration contains two sections, sites and databases.

 This section provideds a token `<full-domain>` that is populated with
 the fully qualified domain(FQD) created from the concatenation of the
 `hostname` and `tld` settings from the vagrant section it may be used in
 place of specifying a static FQD.

### `sites`

Sites contain a keyed array of web sites that will be on the guest machine
and based on the settings provided here each sites docroot will be created
and setup as a synced directory between the host and guest machine. It will
also configure Apache2 to host the site.

For advanced configuration of the synced folders to add excludes and other
available options supplied from Vagrant do *not* add the host docroot here, but
rather add the host docroot as a host directory with a guest in the [vlamp::Advanced settings::synced_folders](#advanced-settings)
configuration section.

The key provided for a site must be a fully qualified domain.

No defaults are supplied. See the example.

**example:**

```
<full-domain>:
  host_docroot: ../docroot
  guest_docroot: /home/vagrant/docroot
  aliases:
    - alias.<full-domain>
  ssl_certificate: /home/vagrant/assets/ssl/<full-domain>.cert
  ssl_certificate_key: /home/vagrant/assets/ssl/<full-domain>.key
another-site.<full-domain>:
  guest_docroot: /home/vagrant/another-site
```

* `guest_docroot` (required)

    The docroot of the site on the guest machine.

* `host_docroot` (optional)

    The directory that is on the host machine that should by synced to the guest
    machine as the docroot of the site.

* `aliases` (optional)

    Any fully qualified domains that should be set as aliases for the site.

* `ssl_certificate` (optional)

   The ssl certificate to use for the site. Typically the certificate will be
   placed in the assets directory for use on the guest machine, however, it may
   be placed in any synced directory. See [creating a self signed certificate](../assets/ssl).

* `ssl_certificate_key` (optional)

   The ssl key to use for the site. Typically the key will be placed in the
   assets directory for use on the guest machine, however, it may be placed in
   any synced directory. See [creating a self signed certificate](../assets/ssl).

### `databases` (optional)

Contains an array of databases that should be created for the sites if any are
required. All that is needed is a database name.

The sites token `<full-domain>` will replace periods(.) with underscores(\_).

**example:**

```
 - <full-domain>
 - my_database
 - another_database
```

utils
-------

The utils section is a higher level abstration of attribute overrides for the
dStack utils cookbook and its recipes. See the [utils cookbook documentation](../cookbooks/local-cookbooks/utils)
for additional information.

The utils section also respects the use of the <full-domain> token as mentioned
in the [sites](#sites) section.

**example:**
```
scripts:
  post-install:
    - docroot/sites/all/dstack/install.sh
  post-up:
    - docroot/sites/all/dstack/up.sh
```

**default:**
```
phpmyadmin:
   domain: phpmyadmin.<full-domain>
webgrind:
   domain: webgrind.<full-domain>
xdebug:
   domain: xdebug.<full-domain>
```

chef
-------

The chef section within the configuration is where the recipe runlist is set
and recipe attribute overrides are done.

Nothing is setup as default for this as it completely depends on what is needed
based on the project, however, checkout the example.dstack.yml file for an idea
of what would necessary.

To add recipes to the run list add them under the `recipes` header.

**example:**
```
recipes:
  - avahi
  - default-web
  - drupal
  - utils::dev-tools
  - utils::phpmyadmin
  - utils::scripts
  - utils::xdebug
```

To override recipe attributes use the following format:

```
COOKBOOK_NAME:
  RECIPE_NAME:
    ATTRIBUTE_NAME: ATTRIBUTE_VALUE
```

**example:**
```
lamp:
  php:
    memory_limit: 128M
```
