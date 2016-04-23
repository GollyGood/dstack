#
# Cookbook Name:: apache2
# Attributes:: mod_fastcgi
#
# Copyright 2013, Chef Software, Inc.
# Copyright 2016, Alexander van Zoest
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

default['apache']['mod_fastcgi']['download_url'] = 'http://www.fastcgi.com/dist/mod_fastcgi-current.tar.gz'
default['apache']['mod_fastcgi']['install_method'] = 'package'
default['apache']['mod_fastcgi']['package'] =
  case node['platform_family']
  when 'debian'
    'libapache2-mod-fastcgi'
  when 'rhel'
    'mod_fastcgi'
  when 'freebsd'
    if node['apache']['version'] == '2.4'
      'ap24-mod_fastcgi'
    else
      'ap22-mod_fastcgi'
    end
  else
    'mod_fastcgi'
  end
