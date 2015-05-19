utils
=====

The utils cookbook is a collection of utility recipes that install and configures
various developer tools and site utilities.

default recipe
--------------

The default recipe does absolutely nothing. It is just there for the sanity of
chef. Meaning that each recipe must be added to the run list independently.

dev-tools recipe
----------------

The dev-tools recipe installs and configures various developer tools that are
useful when doing work on the guest machine itself. While, it isn't recommend
that work be done directly on the guest machine it is sometimes necessary to
pull down files, checkout git repositories, and edit files. To that end we
included tools such as git, rsync, and vim.

**There are no attributes at this time.**

phpmyadmin recipe
-----------------

The phpmyadmin recipe installs and configures the web based MySQL database
administration tool [phpMyAdmin](http://www.phpmyadmin.net/home_page/index.php).

By default when added to the run list phpMyAdmin may be found at
http://phpmyadmin.<full-domain>.

The user name and passwor are the same as MySQL's root user's.

user name: root
password: password

scripts recipe
--------------

The scripts recipe runs user supplied scripts that may be written in any language
during `vagrant up`. These scripts may either be ran on every `provision` or only
once during the very first `vagrant up` depending on the scripts naming
convention.

dStack provides a PHP adapater class that may be used for retrieving
configuration settiings from chef. See the [adapter and example script](../../../dstack/scripts)
for additional information.

### Attributes

    * `scripts::post-install`

    An array of paths to scripts to run once on the very first up on the guest
    machine.

    **example:**
    ```
    - docroot/sites/all/dstack/install.sh
    ```

    * `scripts::post-up`

    An array of paths to scripts to run every time provisioning takes place on
    the guest machine.

    **example:**
    ```
    - docroot/sites/all/dstack/up.sh
    ```

solr recipe
-----------

webgrind recipe
---------------

xhprof recipe
-------------

xdebug recipe
-------------
