# -*- mode: ruby -*-
# vi: set ft=ruby :

class VLAMP
  attr_reader :config

  def initialize()
    @config_file = 'config.yml'
    @config = {}
    @config_defaults = {
      :box => 'hashicorp/precise64',
      :ipaddress => '192.168.33.10',
      :memory => 2048,
      :synced_folders => {'../docroot' => '/home/vagrant/docroot'},
      :synced_folders_type => 'nfs',
      :host => 'web',
      :tld => 'vlamp',
      :guest_docroot => '/home/vagrant/docroot',
      :recipes => ['default-web'],
    }

    @config = load_config(@config_file)
    @config = set_hostname(@config)
    validate_required_settings(@config)

    @config = prefix_hash_keys(@config)
  end

  def load_config(config_file)
    config = {}

    if (File.exists?(config_file) and config_overrides = YAML::load_file(config_file))
      config = @config_defaults.merge(config_overrides)
    else
      raise 'Unable to load the config file "%s" either because it does not exist or it is not in valid YAML format.' % [config_file]
    end

    return config
  end

  def prefix_hash_keys(config)
    new_config = {}

    config.each_pair do |key, value|
      # We only want to prefix keys we have defaults set for here (excluding recipes)
      # so that users may override cookbook attributes as well.
      if @config_defaults.has_key? key and not key.eql? :recipes
        new_config["vlamp_#{key}".to_sym] = value
      else
        new_config[key] = value
      end
    end

    return new_config
  end

  def set_hostname(config)
    config[:hostname] = "#{config[:host]}.#{config[:tld]}"
    return config
  end

  def validate_required_settings(config)
    @config_defaults.each_pair do |key, value|
      if not config.include?(key) or not config[key].kind_of?(value.class)
        raise ArgumentError, 'Unable to find %s %s in %s' % [type, value.class, @config_file]
      end
    end
  end
end
