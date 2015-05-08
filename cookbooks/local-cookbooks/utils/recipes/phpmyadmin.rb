#
# Cookbook Name:: utils
# Recipe:: phpmyadmin
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

include_recipe 'avahi'
include_recipe 'lamp'
include_recipe 'phpmyadmin'

package 'php5-mcrypt' do
  action :install
end

phpmyadmin_db 'phpmyadmin' do
  host '127.0.0.1'
  port node['mysql']['port']
  username 'root'
  password node['mysql']['server_root_password']
  hide_dbs %w( information_schema mysql phpmyadmin performance_schema )
end

if node['utils']['phpmyadmin']['domain'] != ''
  avahi_alias node['utils']['phpmyadmin']['domain'] do
    action :add
  end

  web_app node['utils']['phpmyadmin']['domain'] do
    cookbook 'apache2'
    allow_override 'All'
    docroot node['phpmyadmin']['home']
    server_aliases []
    server_name node['utils']['phpmyadmin']['domain']
  end
end
