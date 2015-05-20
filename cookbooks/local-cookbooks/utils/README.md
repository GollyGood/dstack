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
`http://phpmyadmin.<full-domain>`. This may be modified by the
`utils::phpmyadmin::domain` attribute.

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
   machine. The path by default is relative to vagrant's home directory, however,
   any path may be used.

   **example:**
   ```
   - docroot/sites/all/dstack/install.sh
   ```

   * `scripts::post-up`

   An array of paths to scripts to run every time provisioning takes place on
   the guest machine. The path by default is relative to vagrant's home directory, however,
   any path may be used.

   **example:**
   ```
   - docroot/sites/all/dstack/up.sh
   ```

solr recipe
-----------

The solr recipe handles the installation of Apache Solr versions 3.x or 4.x
only on Jetty. Based on the version of Apache Solr this recipe alters the Java
requirements.

*Note: Depending on what is being done with ApacheSolr, it will most likely be
required that additional customizations will need to be done.* See [drupal::solr](../drupal#solr-recipe)


For additional information see the following cookbooks:

* [java](../../berks-cookbooks/java)
* [hipsnip-jetty](../../berks-cookbooks/hipsnip-jetty)
* [hipsnip-solr](../../berks-cookbooks/hipsnip-solr)

webgrind recipe
---------------

The webgrind recipe installs and configures [Webgrind](https://github.com/jokkedk/webgrind),
a Xdebug web profiling frontend for PHP5 and its dependencies.

By default when added to the run list XhProf may be found at
`http://webgrind.<full-domain>`.

To begin profiling using Webgrind, after the recipe has been added to the
recipe run list and provisioned, add `?XDEBUG_PROFILER=1` to your site's url
for the page you wish to profile.

### Attributes

    * `webgrind::docroot`

    The location on the guest to install Webgrind at.

    **default:** `/var/www/webgrind`

    * `webgrind::domain`

    The domain to use for navigating to the Webgrind interface.

    **default:** `http://webgrind.<full-domain>`

    * `webgrind::storageDir`
    * `webgrind::profilerDir`
    * `webgrind::preprocessedSuffix`
    * `webgrind::defaultTimezone`
    * `webgrind::dateFormat`
    * `webgrind::defaultCostformat`
    * `webgrind::defaultFunctionPercentage`
    * `webgrind::defaultHideInternalFunctions`
    * `webgrind::pythonExecutable`
    * `webgrind::dotExecutable`
    * `webgrind::fileUrlFormat`
    * `webgrind::traceFileListFormat`

xhprof recipe
-------------

The xhprof recipe installs and configures [XHProf](https://github.com/phacility/xhprof),
a web based function-level hierarchical profiler frontend for PHP and its
dependencies.

By default when added to the run list XhProf may be found at
`http://xhprof.<full-domain>`.

@todo: Add notes about settings for Drupal.

### Attributes

    * `xhprof::domain`

    The domain to use for navigating to the XHProf interface.

    **default:** `http://xhprof.<full-domain>`

    * `xhprof::docroot`
    * `xhprof::html`

xdebug recipe
-------------

The xdebug recipe installs and configures [Xdebug](http://xdebug.org/),
the PHP debugger and profiling tool and its dependencies.

### Attributes

    * `xdebug::directives`

    Used to set all Xdebug directives. Checkout its settings that maybe set
    at its site [Xdebug: Documentation - All settings](http://xdebug.org/docs/all_settings).
    By default all directives are using the Xdebug default with exception of the
    ones listed below.

    **default:**
    ```
    profiler_output_name: cachegrind.out.%t-%s
    remote_enable: 1
    profilter_enable_trigger: 1
    ```
