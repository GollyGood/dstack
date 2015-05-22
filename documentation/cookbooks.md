Cookbooks
=========

Local cookbooks
---------------

### [default-web](../cookbooks/local-cookbooks/default-web)

A simple cookbook implementation for setting up development sites based on the
`sites` attribute from the configuration file. This cookbook will not only
set-up and configure Apache2 for http sites, but also https sites, and MySQL
databases for the specified sites. This cookbook may either be used as is or
copied to create a custom site cookbook for setting up sites however is required.

### [drupal](../cookbooks/local-cookbooks/drupal)

A helper cookbook that installs and configures components specifically for
Drupal. It includes additional PHP module requirements for Drupal, Drush and
its requirements, and additional specific configurations for Apache Solr.

### [lamp](../cookbooks/local-cookbooks/lamp)

The lamp cookbook installs the base components for a traditional -AMP
environment, including Apache2, MySQL, and PHP. It also includes some additional
packages including [suhosin](https://suhosin.org/stories/index.html) for
security and [APC](http://php.net/manual/en/book.apc.php) for performance as
they are traditionally included in enterprise hosting environments.

### [utils](../cookbooks/local-cookbooks/utils)

A cookbook that contains utilities for developers and advanced packages for sites.

* [dev-tools](../cookbooks/local-cookbooks/utils#dev-tools-recipe)

    Installs and configures development tools like git, rsync, and vim.

* [phpmyadmin](../cookbooks/local-cookbooks/utils#phpmyadmin-recipe)

    Installs and configures the web based MySQL database administration tool
    [phpMyAdmin](http://www.phpmyadmin.net/home_page/index.php).

* [scripts](../cookbooks/local-cookbooks/utils#scripts-recipe)

    Runs user supplied scripts that may be written in any language during
    `vagrant up`. These scripts may either be ran on every `provision` or only
    once during the very first `vagrant up` depending on the scripts naming
    convention.

* [solr](../cookbooks/local-cookbooks/utils#solr-recipe)

    Installs and configures Apache Solr package. *Note: Depending on what is
    being done with ApacheSolr, it will most likely be required that additional
    customizations will need to be done.*

* [webgrind](../cookbooks/local-cookbooks/utils#webgrind-recipe)

    Installs and configures [Webgrind](https://github.com/jokkedk/webgrind), a
    Xdebug web profiling frontend for PHP5.

* [xhprof](../cookbooks/local-cookbooks/utils#xhprof-recipe)

    Installs and configures [XHProf](https://github.com/phacility/xhprof), a
    web based function-level hierarchical profiler frontend for PHP.

* [xdebug](../cookbooks/local-cookbooks/utils#xdebug-recipe)

    Installs and configures [Xdebug](http://xdebug.org/), the PHP debugger and
    profiling tool.

Vendor Cookbooks
----------------

Vendor cookbooks are 3rd party cookbooks that are pulled from the Chef community
at large and are dependencies for the dStack specific cookbooks. These cookbooks
are managed via [Berkshelf](http://berkshelf.com/) and stored in
`cookbooks/berks-cookbooks`. They are included as part of dStack for ease of
use and maintain their copyrights as provided by their original authors.
[See NOTICE](../NOTICE)

Custom Cookbooks
----------------

If you need to install custom cookbooks add your cookbooks to `cookbooks/custom-cookbooks`.
Check out [custom cookbooks](../cookbooks/custom-cookbooks) for information on
adding your custom recipes to the run list.
