#
# Handler name: base
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

require 'json'

# Base dStack configuration handler.
class DStackConfig < Object
  class << self
    attr_reader :children

    def inherited(klass)
      @children << klass
    end
  end
  @children = []

  attr_accessor :values

  def initialize
    @values = {}
    @defaults = {}
    @allow_extraneous_data = true
  end

  def values_load(values)
    @values = @defaults

    values.each_pair do |key, value|
      @values[key] = value if @allow_extraneous_data || @defaults.key?(key)
    end

    @values
  end

  # rubocop:disable TrivialAccessors
  def values_alter_self
    @values
  end
  # rubocop:enable TrivialAccessors

  def values_alter_all(_dstack)
  end

  def values_finalize_all(_dstack)
  end

  def [](key)
    @values[key]
  end

  def empty?
    @values.empty?
  end

  def key?(key)
    @values.key?(key)
  end

  # @todo: Remove once we have all "has_key?" removed.
  def has_key?(key)
    @values.key?(key)
  end

  def to_json
    @values.to_json
  end

  def set_value(key, value)
    @values[key] = value
  end
end
