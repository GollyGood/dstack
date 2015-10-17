name 'drupal'
maintainer 'dStack Development Team'
maintainer_email 'delaigle.jonathan@gmail.com'
license 'Apache 2.0'
description 'Configures web site.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
recipe 'drupal::solr', 'Installs and configures ApacheSolr for Drupal.'
recipe 'drupal::varnish', 'Installs and configures varnish for Drupal.'
version '0.0.1'
depends 'composer'
depends 'hipsnip-solr'
depends 'php'
depends 'varnish'
