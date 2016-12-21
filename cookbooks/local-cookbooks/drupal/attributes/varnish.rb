#
# Cookbook Name:: utils
# Attributes:: varnish
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

include_attribute 'varnish'

default['drupal']['varnish']['package_version'] = '3.0.7-1~jessie'

force_default['varnish']['backend_host'] = '127.0.0.1'
force_default['varnish']['backend_port'] = 80
force_default['varnish']['secret-non_secure'] = '49d7f218-231f-4e32-9582-f1aa8168b95e'
force_default['varnish']['vcl_source'] = 'varnish-3.erb'
force_default['varnish']['version'] = '3.0'
