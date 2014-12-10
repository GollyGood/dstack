#
# Cookbook Name:: default-web
# Recipe:: default
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

include_recipe "lamp"

def get_aliases(site)
  aliases = []

  if site.has_key?('aliases')
    site['aliases'].each do |site_alias|
      aliases << site_alias
    end
  end

  return aliases
end

vlamp = JSON.parse(node['dstack']['vlamp'])
vagrant = JSON.parse(node['dstack']['vagrant'])

vlamp['sites'].each_pair do |key, value|
  server_name = key
  aliases = get_aliases(value)

  web_app server_name do
    allow_override "All"
    docroot value['guest_docroot']
    server_aliases aliases
    server_name server_name
  end

  # Append configured domain to /etc/hosts file.
  ruby_block "append_hosts" do
    block do
      file = Chef::Util::FileEdit.new("/etc/hosts")
      file.insert_line_if_no_match("127.0.0.1\t#{server_name}", "127.0.0.1\t#{server_name}")
      file.write_file
    end
  end
end

vlamp['databases'].each do |database_name|
  mysql_database database_name do
    connection({
      :host => 'localhost',
      :username => 'root',
      :password => node['mysql']['server_root_password'],
    })
    action :create
  end
end

php_pear "Console_Table" do
  action :install
end

# Initialize drush PEAR channel
dc = php_pear_channel "pear.drush.org" do
  action :discover
end

# Install drush
php_pear "drush" do
  version '6.2.0.0'
  channel dc.channel_name
  action :install
end
