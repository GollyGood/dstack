#
# Cookbook Name:: lamp
# Attributes:: default

include_attribute "apache2"
include_attribute "build-essential"
include_attribute "mysql::server"
include_attribute "php"

# Make sure we install build essentials for ruby gems and PECL packages.
override['build_essential']['compiletime'] = true

# APC settings.
default['lamp']['apc']['enabled'] = 1
default['lamp']['apc']['shm_size'] = "128M"
default['lamp']['apc']['shm_segments'] = 1
default['lamp']['apc']['stat'] = 1
default['lamp']['apc']['cache_by_default'] = 1
default['lamp']['apc']['num_files_hint'] = 8000
default['lamp']['apc']['user_entries_hint'] = 8000
default['lamp']['apc']['ttl'] = 14400
default['lamp']['apc']['user_ttl'] = 600
default['lamp']['apc']['gc_ttl'] = 600
default['lamp']['apc']['max_file_size'] = "2M"
default['lamp']['apc']['rfc1867'] = 1
default['lamp']['apc']['mmap_file_mask'] = "/tmp/XXXXXX"

# PHP settings.
default['lamp']['php']['apache_conf_dir'] = '/etc/php5/apache2'
default['lamp']['php']['error_reporting'] = 'E_ALL'
default['lamp']['php']['memory_limit'] = '128M'

# MySQL settings.
default['mysql']['server_root_password'] = 'password'
default['mysql']['server_debian_password'] = 'password'
default['mysql']['server_repl_password'] = 'password'
override['mysql']['tunable']['max_allowed_packet'] = "64M"
override['mysql']['tunable']['max_connections'] = "40"
override['mysql']['tunable']['query_cache_limit'] = "8M"
override['mysql']['tunable']['query_cache_size'] = "64M"
