#
# Cookbook Name:: apache2
# Attributes:: mod_php5
#
# Copyright 2014, Viverae, Inc.
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

default['apache']['mod_php5']['install_method'] = 'package'
default['apache']['mod_php5']['so_filename'] = 'libphp5.so'

if node['platform'] == 'amazon' && node['apache']['version'] == '2.4'
  default['apache']['mod_php5']['so_filename'] = 'libphp.so'
end