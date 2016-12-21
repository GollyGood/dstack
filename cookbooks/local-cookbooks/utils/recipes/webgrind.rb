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

package 'graphviz' do
  action :install
end

php_pear 'Image_GraphViz' do
  preferred_state 'beta'
  action :install
end

git node['utils']['webgrind']['docroot'] do
  repository 'git://github.com/jokkedk/webgrind.git'
  reference '077f79f13ddc8efa4cb10c2c041eb4b50037e0e3'
  action :sync
end

web_app node['utils']['webgrind']['domain'] do
  cookbook 'apache2'
  allow_override 'All'
  docroot node['utils']['webgrind']['docroot']
  server_aliases []
  server_name node['utils']['webgrind']['domain']
end

template "#{node['utils']['webgrind']['docroot']}/config.php" do
  source 'webgrind.config.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
