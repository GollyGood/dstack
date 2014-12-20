#
# Cookbook Name:: drupal
# Attributes:: solr
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

include_attribute 'hipsnip-solr'

default['drupal']['solr']['module_path'] = ''

if node['solr']['version'].start_with?('4')
  default['drupal']['solr']['apachesolr_conf_dir'] = 'collection1/conf'
  default['drupal']['solr']['module_conf_dir'] = 'solr-conf/solr-4.x'
else
  default['drupal']['solr']['apachesolr_conf_dir'] = 'conf'
  default['drupal']['solr']['module_conf_dir'] = 'solr-conf/solr-3.x'
end

default['drupal']['solr']['module_conf_files'] = [
  'protwords.txt',
  'schema.xml',
  'schema_extra_fields.xml',
  'schema_extra_types.xml',
  'solrconfig.xml',
  'solrconfig_extra.xml',
  'solrcore.properties'
]
