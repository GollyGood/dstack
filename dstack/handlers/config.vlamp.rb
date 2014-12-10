#
# Handler name: vlamp
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

class DStackConfigVLAMP < DStackConfig
  def name()
    return 'vlamp'
  end

  def initialize()
    @allow_extraneous_data = false
    @defaults = {
      'sites' => {
        '<default>' => {
          'guest_docroot' => '/var/www',
        }
      },
      'databases' => []
    }
  end

  def values_alter_all(dstack)
    values_alter_vagrant_add_synced_folders(dstack)
    values_alter_process_tokens(dstack)
    values_alter_process_databases(dstack)
  end

  def values_alter_vagrant_add_synced_folders(dstack)
    vagrant = dstack.get_config('vagrant')

    @values['sites'].each_pair do |key, value|
      if value.has_key?('host_docroot') and value.has_key?('guest_docroot')
        vagrant.values['synced_folders'][value['host_docroot']] = value['guest_docroot']
      end
    end
  end

  def values_alter_process_tokens(dstack)
    vagrant = dstack.get_config('vagrant')

    tmp_configs = @values.to_json
    tmp_configs = tmp_configs.gsub '<hostname>', vagrant['hostname']
    @values = JSON.parse(tmp_configs)
  end

  def values_alter_process_databases(dstack)
    @values['databases'].map! do |database|
      # Tokens may had placed periods in the names. Since mysql doesn't support
      # periods we should replace them with underscores.
      database.sub '.', '_'
    end
  end
end
