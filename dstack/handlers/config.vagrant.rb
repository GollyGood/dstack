#
# Handler name: vagrant
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

# Vagrant configuration handler.
class DStackConfigVagrant < DStackConfig
  def name
    'vagrant'
  end

  def initialize
    super
    @allow_extraneous_data = false
    @defaults = {
      'hostname' => 'default',
      'tld' => 'local',
      'box' => 'hashicorp/precise64',
      'networks' => { 'private_network' => { :type => 'dhcp' } },
      'ipaddress' => '',
      'memory' => 2048,
      'synced_folders' => {},
      'synced_folders_type' => 'nfs',
      'assets_folder' => {'host_directory' => 'assets', 'guest_directory' => '/home/vagrant/assets'},
      'tld' => 'local',
      'forward_agent' => true
    }
  end

  def values_alter_self
    values_alter_self_add_assets_synced_folder()
  end

  def values_alter_self_add_assets_synced_folder()
    if (values['assets_folder'].has_key?('host_directory') && values['assets_folder'].has_key?('guest_directory'))
      values['synced_folders'][values['assets_folder']['host_directory']] = values['assets_folder']['guest_directory']
    end
  end
end
