# -*- mode: ruby -*-
# vi: set ft=ruby :

Dir[File.dirname(__FILE__) + '/handlers/*.rb'].sort.each { |file| require file }
require 'yaml'

# Main dStack class.
class DStack
  attr_reader :configs

  def initialize(config_file = '')
    @configuration = DStackConfig
    @configs = {}

    load_config_wrappers
    load_configs_from_file(config_file)
  end

  def load_config_wrappers
    @configuration.children.each do |child|
      # We do this here because... well as far as I can tell the child's
      # initialize() is not called when called from a static method.
      # I am thinking this has something to do with the fact that Ruby does not
      # respect polymorphism from static methods. Could someone confirm this for
      # me or correct me as to why this might be?
      instanciated_child = child.new
      @configs[instanciated_child.name] = instanciated_child
    end

    @configs
  end

  def load_configs_from_file(config_file)
    configs = File.exist?(config_file) ? YAML.load_file(config_file) : {}
    if configs.empty?
      fail format('Unable to load the config file "%s" either because it does not exist or it is not in valid YAML format.', config_file)
    else
      @config_file = config_file

      loaded_configs = {}
      @configs.each_pair do |_config_name, config|
        values = configs.key?(config.name) ? configs[config.name] : {}
        load_config_values(config, values)
        loaded_configs[config.name] = config
      end

      @configs = loaded_configs
    end

    alter_all_configs
    finalize_all_configs
    @configs
  end

  def load_config_values(config, values)
    config.values_load(values)
    config.values_alter_self

    !config.values.empty? ? true : false
  end

  def alter_all_configs
    @configs.each_value do |config|
      config.values_alter_all(self)
    end
  end

  def finalize_all_configs
    @configs.each_value do |config|
      config.values_finalize_all(self)
    end
  end

  def get_config(config_name)
    fail format('Unable to retrieve "%s" configuration from configurations.', config_name) unless @configs.key?(config_name)

    @configs[config_name]
  end

  def chef_array
    chef_values = get_config('chef').values
    chef_values['dstack'] = {}

    @configs.each_pair do |config_name, config|
      if config_name != 'chef'
        chef_values['dstack'][config_name] = config.to_json
      end
    end
    chef_values
  end
end
