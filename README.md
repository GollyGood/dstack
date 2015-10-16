[![dStack logo](http://dstack.gollygood.software/images/dstack-logo.jpg)](http://dstack.gollygood.software)

[![Stories in Ready](https://badge.waffle.io/gollygood/dstack.png?label=Ready)](https://waffle.io/gollygood/dstack)

Version: 1.0.0-beta (CaneSyrup)

dStack(short for "development stack") is a Vagrant+Chef powered LAMP stack that
allows setup of web nodes via a configuration YAML file. The primary target
users are enterprise development teams that need similar-to-production
development.

What's in the stack?
--------------------
Component     | Version(s)                  | Notes
------------- | --------------------------- | -------------
Apache2       | 2.2, 2.4                    |
ApacheSolr    | 3.x(default) or 4.x         |
APC           | 3.1.7, 4.0.6                |
Box OS        | Ubuntu 12.04                |
Chef Solo     | 10.14.2                     |
Drush         | 7.0.0                       |
Git           | 1.7.9.5                     |
MySQL         | 5.5                         |
PHP           | 5.3, 5.5, 5.6               |
ruby          | 1.9.3                       |
varnish       | 3.x(default) or 4.x         |
tika          |                             | @todo: Add tika.
vim           | 7.3                         |
Webgrind      | master                      | Commit: 077f79f13ddc8efa4cb10c2c041eb4b50037e0e3
Xdebug        | 2.2.7                       |
XHprof        | beta                        | @todo: Lock to version

Requirements
------------

* Ruby >= 2.1.1
* Vagrant >= 1.6.3
* nfs
  * Ubuntu
    * Will need to be [installed](https://help.ubuntu.com/lts/serverguide/network-file-system.html) if using nfs.
    * Will also need to either configure your firewall for NFS or turn of your firewall if enabled. We are current looking to see what we can do about this on this [issue](https://github.com/gollygood/dstack/issues/10).
    * Cannot be ran in an encrypted home directory or sharing directories in an encrypted home directory. Entire disk encryption is fine.
  * MacOSX - Already contains a working version of nfs.

**Windows is not supported.**

[Documentation](documentation)
------------------------------

The documentation is included as part of the codebase for easier reference
and continuity of versions of dStack. Each cookbook contains its own
documentation, however, an index of all documentation may be found in the
[documentation](documentation) directory along with any higher level
documentation that corresponds to dStack.

Bugs
----

Submit all bugs to the [issue queue](https://github.com/gollygood/dstack/issues)
on GitHub.

Contributing
------------

Make changes in a fork and submit a [pull request](https://github.com/gollygood/dstack/pulls).

For development you will need to install [Bundler](http://bundler.io/) and run
`make development`. This will install the tools necessary for development.

Before submitting a pull request run `make test` to make sure your code passes
tests and adheres to the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide).

Sponsors
--------

Development is sponsored by [GollyGood Software](http://www.gollygoodsoftware.com/).

License
-------

Copyright:: 2015 dStack Development Team

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of
the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.

*Vendor software maintain authorship and copyrights of their original authors
under the Apache License see [NOTICE](NOTICE)*.
