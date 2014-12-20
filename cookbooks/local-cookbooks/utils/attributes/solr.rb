#
# Cookbook Name:: utils
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

include_attribute "java"
include_attribute "hipsnip-solr"
include_attribute "hipsnip-jetty"

node['jetty']['port'] = 8983

if node['solr']['version'].start_with?('4')
  node['java']['jdk_version'] = '7'
  node['jetty']['version'] = '9.0.6.v20130930'
  node['jetty']['link'] = 'http://eclipse.org/downloads/download.php?file=/jetty/9.0.6.v20130930/dist/jetty-distribution-9.0.6.v20130930.tar.gz&r=1'
  node['jetty']['checksum'] = 'c35c6c0931299688973e936186a6237b69aee2a7912dfcc2494bde9baeeab58f'
end
