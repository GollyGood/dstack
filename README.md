dStack  [![Stories in Ready](https://badge.waffle.io/grndlvl/dstack.svg)](https://waffle.io/grndlvl/dstack)
=========

dStack short for "development stack" is a Vagrant+Chef powered LAMP stack that allows setup of web nodes via a configuration YAML file. The primary target users are enterprise development teams that need similar-to-production development.

What's in the stack?
-----------
Component     | Version(s)                  | Notes
------------- | --------------------------- | -------------
Apache2       | 2.2                         |
ApacheSolr    | tbd                         | Coming soon
APC           | 3.1.7                       |
Box OS        | Ubuntu 12.04                |
Chef Solo     | 10.14.2                     |
Drush         | 6.02                        |
Git           | 1.7.9.5                     |
MySQL         | 5.5.40                      |
memcache      | tbd                         | Coming soon
PHP           | 5.3.10                      |
ruby          | 1.8.7                       | Coming soon
tika          | tbd                         | Coming soon
varnish       | tbd                         | Coming soon
vim           | 7.3.429                     | Coming soon
Webgrind      | tbd                         |
Xdebug        | tbd                         | Coming soon
XHprof        | tbd                         | Coming soon

Documentation
-----------

The main documentation may be found on the [wiki](https://github.com/grndlvl/dstack/wiki).

Requirements
-----------

* Ruby >= 2.1.1
* Vagrant >= 1.6.3
* nfs
  * Ubuntu
    * Will need to be [installed](https://help.ubuntu.com/lts/serverguide/network-file-system.html) if using nfs.
    * Will also need to turn of your firewall if enabled. We are current looking to see what we can do about this on this [issue](https://github.com/grndlvl/dstack/issues/10).
    * Cannot be ran in an encrypted home directory or sharing directories in an encrypted home directory. Entire disk encryption is fine.
  * MacOSX - Already contains a working version of nfs.
