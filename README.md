[![dStack logo](http://www.grndlvl.com/dstack/images/dstack-logo.jpg)](http://grndlvl.com/dStack)

[![Stories in Ready](https://badge.waffle.io/grndlvl/dstack.png?label=Ready)](https://waffle.io/grndlvl/dstack)

Version: development (CaneSyrup)

dStack(short for "development stack") is a Vagrant+Chef powered LAMP stack that
allows setup of web nodes via a configuration YAML file. The primary target
users are enterprise development teams that need similar-to-production
development.

What's in the stack?
-----------
Component     | Version(s)                  | Notes
------------- | --------------------------- | -------------
Apache2       | 2.2                         |
ApacheSolr    | 3.x(default) or 4.x         |
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
varnish       | 3.x(default) or 4.x         |
vim           | 7.3
Webgrind      | tbd                         |
Xdebug        | 2.2.7                       |
XHprof        | tbd                         | Coming soon

[Documentation](documentation)
-------------

The documentation is included as part of the codebase for easier reference
and continuity of versions of dStack. Each cookbook contains its own
documentation, however, an index of all documentation may be found in the
[documentation](documentation) directory along with any higher level
documentation that corresponds to dStack.

Bugs
----

Submit all bugs to the [issue queue](https://github.com/grndlvl/dstack/issues)
on GitHub.

Contributing
------------

Make changes in a fork and submit a [pull request](https://github.com/grndlvl/dstack/pulls).

For development you will need to install [Bundler](http://bundler.io/) and run
`make development`. This will install the tools necessary for development.

Before submitting a pull request run `make test` to make sure your code passes
tests and adhears to the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide).

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
