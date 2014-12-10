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

class DStackConfigVagrant < DStackConfig
  def name()
    return 'vagrant'
  end

  def initialize()
    super
    @allow_extraneous_data = false
    @defaults = {
      'hostname' => '',
      'host' => 'default',
      'box' => 'hashicorp/precise64',
      'ipaddress' => '192.168.33.10',
      'memory' => 2048,
      'synced_folders' => {},
      'synced_folders_type' => 'nfs',
      'tld' => 'dstack',
      'forward_agent' => true
    }
  end

  def values_alter_self()
    set_hostname()
  end

  def set_hostname()
    if (@values['hostname'] == '')
      @values['hostname'] = "#{@values['host']}.#{@values['tld']}"
    end
  end
end
