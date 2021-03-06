#
# Cookbook Name:: utils
# Attributes:: scripts
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

default['utils']['scripts']['base_path'] = '/home/vagrant/'
default['utils']['scripts']['install_tracker'] = '/home/vagrant/.utils.scripts.installed'
default['utils']['scripts']['config_file'] = '/home/vagrant/.utils.scripts.config.json'
default['utils']['scripts']['post-install'] = []
default['utils']['scripts']['post-up'] = []
