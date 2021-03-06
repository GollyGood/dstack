Makefile
========

The make file has a few helper targets that assit with dStack development and
installing components for users.

all
---

Runs the development target.

apply-patches
-------------

Applies custom patches to 3rd party cookbooks.

apply-version
-------------

Must add `VERSION=X.X.X` as a parameter to the Makefile call.

**example:** $`make apply-version VERSION=0.0.0`

development
-------------

Runs the install-gems target.

install
-------

Installs vagrant ssh key and configures.

install-gems
------------

Installs Ruby gems necessary for development.

install-vendor-cookbooks
------------------------

Installs vendor cookbooks via Berkshelf.

refresh-vendor-cookbooks
------------------------

Deletes and re-installs vendor cookbooks.

delete-vendor-cookbooks
------------------------

Delete all vendor cookbooks.

test
----

Runs all tests and lint checks on codebase.
