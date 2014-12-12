# -*- mode: ruby -*-
# vi: set ft=ruby :

Dir[File.dirname(__FILE__) + '/handlers/*.rb'].sort.each {|file| require file }
require 'yaml'

class DStack
  attr_reader :configs

  def initialize(config_file = '')
    @configuration = DStackConfig
    @configs = {}

    load_config_wrappers()
    load_configs_from_file(config_file)
  end

  def load_config_wrappers()
    @configuration.children.each do |child|
      # We do this here because... well as far as I can tell the child's
      # initialize() is not called when called from a static method.
      # I am thinking this has something to do with the fact that Ruby does not
      # respect polymorphism from static methods. Could someone confirm this for
      # me or correct me as to why this might be?
      instanciated_child = child.new
      @configs[instanciated_child.name] = instanciated_child
    end

    return @configs
  end

  def load_configs_from_file(config_file)
    if (File.exists?(config_file) and configs = YAML.load_file(config_file))
      @config_file = config_file

      loaded_configs = {}
      @configs.each_pair do |config_name, config|
        values = configs.has_key?(config.name) ? configs[config.name] : {}
        load_config_values(config, values)
        loaded_configs[config.name] = config
      end

      @configs = loaded_configs
    else
      raise 'Unable to load the config file "%s" either because it does not exist or it is not in valid YAML format.' % [config_file]
    end

    alter_all_configs()
    finalize_all_configs()
    return @configs
  end

  def load_config_values(config, values)
    config.values_load(values)
    config.values_alter_self()

    return !config.values.empty? ? true : false
  end

  def alter_all_configs()
    @configs.each_value do |config|
      config.values_alter_all(self)
    end
  end

  def finalize_all_configs()
    @configs.each_value do |config|
      config.values_finalize_all(self)
    end
  end

  def get_config(config_name)
    if !@configs.has_key?(config_name)
      raise 'Unable to retrieve "%s" configuration from configurations.' % config_name
    end

    return @configs[config_name]
  end

  def get_chef_array()
    chef_values = get_config('chef').values
    chef_values['dstack'] = {}

    @configs.each_pair do |config_name, config|
      if config_name != 'chef'
        chef_values['dstack'][config_name] = config.to_json
      end
    end
    return chef_values
  end
end
