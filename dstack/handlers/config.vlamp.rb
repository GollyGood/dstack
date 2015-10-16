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

# LAMP configuration handler.
class DStackConfigVLAMP < DStackConfig
  def name
    'vlamp'
  end

  def initialize
    @allow_extraneous_data = false
    @defaults = {
      'sites' => {
        '<full-domain>' => {
          'guest_docroot' => '/var/www'
        }
      },
      'full-domain' => 'example.local',
      'databases' => []
    }
  end

  def values_alter_all(dstack)
    values_alter_vagrant_add_synced_folders(dstack)
    values_alter_set_full_domain(dstack)
    values_alter_process_tokens(dstack)
    values_alter_process_databases(dstack)
    values_alter_chef_append_attributes(dstack)
  end

  def values_alter_vagrant_add_synced_folders(dstack)
    vagrant = dstack.get_config('vagrant')

    @values['sites'].each_pair do |_key, value|
      if value.key?('host_docroot') && value.key?('guest_docroot')
        vagrant.values['synced_folders'] << { 'host_directory' => value['host_docroot'], 'guest_directory' => value['guest_docroot'] }
      end
    end
  end

  def values_alter_set_full_domain(dstack)
    vagrant = dstack.get_config('vagrant')

    if !vagrant['hostname'].empty? && !vagrant['tld'].empty?
      @values['full-domain'] = "#{vagrant['hostname']}.#{vagrant['tld']}"
    end
  end

  def values_alter_process_tokens(_dstack)
    tmp_configs = @values.to_json
    tmp_configs = tmp_configs.gsub '<full-domain>', @values['full-domain']
    @values = JSON.parse(tmp_configs)
  end

  def values_alter_process_databases(_dstack)
    @values['databases'].map! do |database|
      # Tokens may had placed periods in the names. Since mysql doesn't support
      # periods we should replace them with underscores.
      database.sub '.', '_'
    end
  end

  def values_alter_chef_append_attributes(dstack)
    chef = dstack.get_config('chef')

    if chef.values.key?('default-web')
      fail "There exists overrides for default-web under 'chef' in the configuration. Please add these settings under 'vlamp' in your configuration file."
    else
      chef.values['default-web'] = @values
    end
  end
end
