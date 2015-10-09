lamp
====

The lamp cookbook installs the base components for a traditional -AMP
environment, including Apache2, MySQL, and PHP. It also includes some additional
packages including [suhosin](https://suhosin.org/stories/index.html) for
security and [APC](http://php.net/manual/en/book.apc.php) for performance as
they are traditionally included in enterprise hosting environments.

Attributes
----------

Since most of these attributes are settings rather than setup configurations
see the [attributes file](attributes/default.rb). For further explination about
these settings and check out their respective documentation.

## Apache2

* [Apache2 cookbook](../../berks-cookbooks/apache2)

## APC

### Attributes

    * `lamp::apc::*`

    All APC configuration variables have been variabilized and may be set using this array.

* [Server configuration](https://dev.mysql.com/doc/refman/5.5/en/server-configuration-defaults.html)

## PHP

* [PHP cookbook](../../berks-cookbooks/php)
* [Directives](http://php.net/manual/en/ini.list.php)

### Attributes

    * `lamp::php::version`

    The version of PHP may be set and based on that dStack will use Apache 2.2
    or 2.4. Available versions are *5.3, 5.5, 5.6*.

    **default:** `5.3`

    * `lamp::php::apache_conf_dir`

    Determines where we will place Apache PHP mods.

    **default:** `/etc/php5/apache2`

    * `lamp::php::error_reporting`

    The [error_reporting](http://php.net/manual/en/function.error-reporting.php) variable in the php.ini file.

    **default:** `E_ALL`

    * `lamp::php::memory_limit`

    The [memory_limit](http://php.net/manual/en/ini.core.php#ini.memory-limit) variable in the php.ini file.

    **default:** `128`

## MySQL

* [Database cookbook](../../berks-cookbooks/database)
* [MySQL cookbook](../../berks-cookbooks/mysql)
* [Server configuration](https://dev.mysql.com/doc/refman/5.5/en/server-configuration-defaults.html)
