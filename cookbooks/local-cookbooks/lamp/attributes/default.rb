#
# Cookbook Name:: lamp
# Attributes:: default
#
# Copyright 2014 dStack Development Team
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_attribute 'apache2'
include_attribute 'build-essential'
include_attribute 'mysql::server'
include_attribute 'php'

# Make sure we install build essentials for ruby gems and PECL packages.
override['build_essential']['compiletime'] = true

# APC settings.
default['lamp']['apc']['enabled'] = 1
default['lamp']['apc']['shm_size'] = '128M'
default['lamp']['apc']['shm_segments'] = 1
default['lamp']['apc']['stat'] = 1
default['lamp']['apc']['cache_by_default'] = 1
default['lamp']['apc']['num_files_hint'] = 8_000
default['lamp']['apc']['user_entries_hint'] = 8_000
default['lamp']['apc']['ttl'] = 14_400
default['lamp']['apc']['user_ttl'] = 600
default['lamp']['apc']['gc_ttl'] = 600
default['lamp']['apc']['max_file_size'] = '2M'
default['lamp']['apc']['rfc1867'] = 1
default['lamp']['apc']['mmap_file_mask'] = '/tmp/XXXXXX'

# PHP settings.
default['lamp']['php']['apache_conf_dir'] = '/etc/php5/apache2'
default['lamp']['php']['error_reporting'] = 'E_ALL'
default['lamp']['php']['memory_limit'] = '128M'
default['lamp']['php']['display_errors'] = 'On'
default['lamp']['php']['version'] = '5.3'
override['php']['version'] = node['lamp']['php']['version']
force_default['apache']['mpm'] = 'prefork'
force_default['php']['ext_conf_dir'] = '/etc/php5/mods-available'

# MySQL settings.
node.set_unless['mysql']['server_debian_password'] = 'password'
node.set_unless['mysql']['server_root_password']   = 'password'
node.set_unless['mysql']['server_repl_password']   = 'password'
force_default['mysql']['tunable']['max_allowed_packet'] = '64M'
force_default['mysql']['tunable']['max_connections'] = '40'
force_default['mysql']['tunable']['query_cache_limit'] = '8M'
force_default['mysql']['tunable']['query_cache_size'] = '64M'
