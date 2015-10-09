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
      'box' => 'dstack-ubuntu-12.04',
      'box_url' => 'http://devhumans.com/dstack/dstack-ubuntu-12.04.json',
      'networks' => [{ 'private_network' => { :type => 'dhcp' } }],
      'memory' => 2048,
      'synced_folders' => [],
      'synced_folders_type_default' => 'rsync',
      'assets_folder' => { 'host_directory' => 'assets', 'guest_directory' => '/home/vagrant/assets' },
      'tld' => 'local',
      'forward_agent' => true
    }
  end

  def values_alter_self
    values_alter_self_add_assets_synced_folder
  end

  def values_finalize_all(dstack)
    values_alter_self_set_defaults(dstack)
  end

  def values_alter_self_add_assets_synced_folder
    if values.key?('assets_folder')
      values['synced_folders'] << values['assets_folder']
    end
  end

  def values_alter_self_set_defaults(dstack)
    vagrant = dstack.get_config('vagrant')

    vagrant['synced_folders'].each_with_index do |synced_folder, index|
      unless synced_folder.key?('options')
        vagrant['synced_folders'][index]['options'] = {}
      end

      unless synced_folder['options'].key?('type')
        vagrant['synced_folders'][index]['options']['type'] = values['synced_folders_type_default']
      end

    end
  end
end
