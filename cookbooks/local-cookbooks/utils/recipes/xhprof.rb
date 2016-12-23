#
# Cookbook Name:: utils
# Recipe:: xdebug
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

include_recipe 'git'
include_recipe 'lamp'
include_recipe 'utils::xdebug'

php_pear 'xhprof' do
  version node['utils']['xhprof']['version']
  preferred_state 'beta'
  action :install
end

package 'graphviz' do
  action :install
end

link node['utils']['xhprof']['docroot'] do
  to node['utils']['xhprof']['html']
end

web_app node['utils']['xhprof']['domain'] do
  cookbook 'apache2'
  allow_override 'All'
  docroot node['utils']['xhprof']['docroot']
  server_aliases []
  server_name node['utils']['xhprof']['domain']
end
