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

include_recipe 'lamp'
include_recipe 'avahi'

def get_aliases(site)
  aliases = []

  if site.key?('aliases')
    site['aliases'].each do |site_alias|
      aliases << site_alias
    end
  end

  aliases
end

def append_hosts(domain)
  # Append configured domain to /etc/hosts file.
  ruby_block 'append_hosts' do
    block do
      file = Chef::Util::FileEdit.new('/etc/hosts')
      file.insert_line_if_no_match("127.0.0.1\t#{domain}", "127.0.0.1\t#{domain}")
      file.write_file
    end
  end
end

node['default-web']['sites'].each_pair do |key, value|
  server_name = key
  aliases = get_aliases(value)

  append_hosts(server_name)
  aliases.each do |site_alias|
    append_hosts(site_alias)
    avahi_alias site_alias do
      action :add
    end
  end

  web_app server_name do
    allow_override 'All'
    docroot value['guest_docroot']
    server_aliases aliases
    server_name server_name
    port node['default-web']['port']
  end

  if value.key?('ssl_certificate') && value.key?('ssl_certificate_key')
    web_app "#{server_name}-ssl" do
      template 'web_app_ssl.conf.erb'
      allow_override 'All'
      docroot value['guest_docroot']
      server_aliases aliases
      server_name server_name
      ssl_cert_path value['ssl_certificate']
      ssl_key_path value['ssl_certificate_key']
    end
  end
end

node['default-web']['databases'].each do |database_name|
  mysql_database database_name do
    connection(
      :host => 'localhost',
      :username => 'root',
      :password => node['mysql']['server_root_password']
    )
    action :create
  end
end
