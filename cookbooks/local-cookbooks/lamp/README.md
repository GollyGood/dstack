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

### APC

* [Server configuration](https://dev.mysql.com/doc/refman/5.5/en/server-configuration-defaults.html)

### PHP

* [PHP cookbook](../../berks-cookbooks/php)
* [Directives](http://php.net/manual/en/ini.list.php)

### MySQL

* [Database cookbook](../../berks-cookbooks/database)
* [MySQL cookbook](../../berks-cookbooks/mysql)
* [Server configuration](https://dev.mysql.com/doc/refman/5.5/en/server-configuration-defaults.html)
