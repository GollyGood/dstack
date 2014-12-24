#
# Handler name: utils
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

# Utils configuration handler.
class DStackConfigUtils < DStackConfig
  def name
    'utils'
  end

  def initialize
    super
    @allow_extraneous_data = false
    @defaults = {
      'scripts' => {
        'post-install' => [],
        'post-up' => []
      }
    }
  end

  def values_alter_all(dstack)
    values_alter_chef_append_utils_scripts_attributes(dstack)
  end

  def values_alter_chef_append_utils_scripts_attributes(dstack)
    chef = dstack.get_config('chef')

    if chef.values.key?('utils')
      fail "There exists overrides for utils under 'chef' in the configuration. Please add these settings under 'utils' in your configuration file."
    else
      chef.values['utils'] = @values
    end
  end
end
