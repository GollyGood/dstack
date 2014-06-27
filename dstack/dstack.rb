# -*- mode: ruby -*-
# vi: set ft=ruby :

Dir[File.dirname(__FILE__) + '/handlers/*.rb'].sort.each {|file| require file }
require 'yaml'

class DStack
  def initialize()
    @documents = {}
    @config_file = ''
  end

  def load_yaml_config_from_file(config_file)
    if (File.exists?(config_file) and documents = YAML.load_stream(open(config_file)))
      @config_file = config_file

      documents.each do |document|
        @documents[document.name] = document
      end
    else
      raise 'Unable to load the config file "%s" either because it does not exist or it is not in valid YAML format.' % [config_file]
    end

    return @documents
  end

  def get_config(config_name)
    if !@documents.has_key?(config_name)
      raise 'Unable to retrieve "%s" config from documents.' % config_name
    end

    return @documents[config_name]
  end
end
