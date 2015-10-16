#
# Cookbook Name:: drupal
# Recipe:: solr
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

include_recipe 'utils::solr'

module_conf_dir = node['drupal']['solr']['module_conf_dir']
apachesolr_conf_dir = node['drupal']['solr']['apachesolr_conf_dir']

if node['drupal']['solr']['module_path'] == ''
  fail 'Drupal ApacheSolr module directory has not be set.'
elsif !File.directory? node['drupal']['solr']['module_path']
  fail 'Unable to locate the Drupal ApacheSolr module directory. Please check the path.'
end

# Copy the Drupal ApacheSolr conf files to the ApacheSolr conf directory.
node['drupal']['solr']['module_conf_files'].each do |config_file|
  file "#{node['solr']['home']}/#{apachesolr_conf_dir}/#{config_file}" do
    content IO.read("#{node['drupal']['solr']['module_path']}/#{module_conf_dir}/#{config_file}")
    notifies :restart, 'service[jetty]'
  end
end
