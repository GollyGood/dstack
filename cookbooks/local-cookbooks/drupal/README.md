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
