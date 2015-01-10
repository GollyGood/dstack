#
# Cookbook Name:: default-web
# Recipe:: ssl
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
include_recipe 'default-web'

def get_aliasess(site)
  aliases = []

  if site.key?('aliases')
    site['aliases'].each do |site_alias|
      aliases << site_alias
    end
  end

  aliases
end

node['default-web']['sites'].each_pair do |key, value|
  server_name = key
  aliases = get_aliasess(value)

  web_app "#{server_name}-ssl" do
    cookbook 'default-web'
    template 'web_app_ssl.conf.erb'
    allow_override 'All'
    docroot value['guest_docroot']
    server_aliases aliases
    server_name server_name
    ssl_cert_path value['ssl_certificate']
    ssl_key_path  value['ssl_certificate_key']
  end
end
