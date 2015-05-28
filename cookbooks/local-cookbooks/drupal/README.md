drupal
======

The drupal cookbook installs and configures components specifically for Drupal.
It includes additional PHP module requirements for Drupal, Drush and its
requirements, and additional specific configurations for Apache Solr.


default recipe
--------------

The default recipe installs Drush, Console_Table, and the uploadprogress php
module.

### Drush

Since drupal cookbook installs drush, if you have drush installed on the host machine
you may use drush with your development site. See below for an example alias.

**example:**
```
$aliases['example'] = array(
  'uri' => 'example.local',
  'root' => '/home/vagrant/docroot',
  'remote-host' => 'example.local',
  'path-aliases' => array(
    '%drush-script' => '/usr/local/bin/drush',
    '%dump-dir' => '/tmp',
  ),
  'remote-user' => 'vagrant',
);
```

### Attributes

* `drush::version`

    Is the verion of drush to install from PHP's PEAR. Note the additional 0 at the
    end. To see available versions see [Drush's pear channel](http://pear.drush.org/).

    **default:** `6.2.0.0`


solr recipe
-----------

The solr recipe is used to configure Apache Solr to be used for Drupal. In order
to use this recipe you will need to have a Drupal module that contains the
Apache Solr configuration XML documents.

Supported Drupal modules:

* [Apache Solr Search](https://www.drupal.org/project/apachesolr)
* [Search API Solr Search](https://www.drupal.org/project/search_api_solr)

*Note: While we specifically only suppor the two aforementioned modules this
recipe should work with any Drupal Apache Solr module that contains the
configuration XML documents.*

### Attributes

* `solr::module_path`

    The path to the Drupal Apache Solr module within the site's docroot.

    **example:** `sites/all/modules/contrib/apachesolr`

* `solr::module_conf_dir`

    The configuration directory within the Drupal Apache Solr module.

    **4.x default:** `solr-conf/solr-4.x`

    **3.x default:** `solr-conf/solr-3.x`

* `solr::module_conf_files`

    An array of files to use from within the Drupal Apache Solr module configuration
    directory.

    **default:**
    ```
    'protwords.txt',
    'schema.xml',
    'schema_extra_fields.xml',
    'schema_extra_types.xml',
    'solrconfig.xml',
    'solrconfig_extra.xml',
    'solrcore.properties'
    ```

* `solr::apachesolr_conf_dir`

    The configuration directory for Apache Solr relative to the Apache Solr home
    directory. See the [hipsnip-solr cookbook](../../berks-cookbooks/hipsnip-solr)
    for additional information.

    **4.x default:** `collection1/conf`

    **3.x default:** `conf`


varnish recipe
--------------

The varnish recipe installs and configures [Varnish](https://www.varnish-cache.org/)
for use with Drupal.

To vist a page served by Varnish go to `http://<full-domain>:6081`.

Currently only version 3.x is supported.

To configure Drupal add the following to your `settings.php` file:

```
/**
 * Varnish settings.
 */
$conf['reverse_proxy'] = TRUE;
// Include in this array all webheads, load balancers, and 127.0.0.1.
$conf['reverse_proxy_addresses'] = array('127.0.0.1');

// Varnish control terminal.
// Usually the internal IP of all webheads on port 6082 space separated.
$conf['varnish_control_terminal'] = '127.0.0.1:6082';
$conf['varnish_control_key'] = '49d7f218-231f-4e32-9582-f1aa8168b95e';
$conf['varnish_version'] = '3';

// Drupal 7 does not cache pages when we invoke hooks during bootstrap. This
// needs to be disabled.
$conf['cache_backends'][] = 'sites/all/modules/contrib/varnish/varnish.cache.inc';
$conf['cache_class_cache_page'] = 'VarnishCache';
$conf['page_cache_invoke_hooks'] = FALSE;
```

###Attributes

* `varnish::backend_host`

  The host of the webserver.

  **default:** `127.0.0.1`

* `varnish::backend_port`

  The port of the webserver backend.

  **default:** `80`

* `varnish::secure-non_secure`

  The secure key to use with varnish.

  **default:** `49d7f218-231f-4e32-9582-f1aa8168b95e`

* `varnish::vcl_source`

  The template to use for creating the VCL file.

  **default:** `varnish-3.erb`

* `varnish::version`

  The version of varnish to use.

  **default:** `3.0`

For additional attributes see the [varnish cookbook](../berks-cookbooks/varnish)
