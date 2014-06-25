# -*- mode: ruby -*-
# vi: set ft=ruby :

class VLAMPConfig
  attr_reader :values

  def initialize(config_file)
    @config_file = config_file
    @values = {}
    @defaults = {
      :box => 'hashicorp/precise64',
      :ipaddress => '192.168.33.10',
      :memory => 2048,
      :synced_folders => {},
      :synced_folders_type => 'nfs',
      :host => 'web',
      :hostname => '',
      :tld => 'vlamp',
      :guest_docroot => '/home/vagrant/docroot',
      :recipes => ['default-web'],
      :sites => {},
      :sites_count => 0,
    }

    @values = load_config(@config_file)
    validate_required_settings(@values)

    @values = set_hostname(@values)
    @values = set_synced_folders(@values)
  end

  def get_value(key)
    return @values.has_key?(key) ? @values[key] : nil
  end

  def load_config(config_file)
    config = {}

    if (File.exists?(config_file) and config_overrides = YAML::load_file(config_file))
      config = @defaults.merge(config_overrides)
    else
      raise 'Unable to load the config file "%s" either because it does not exist or it is not in valid YAML format.' % [config_file]
    end

    return config
  end

  def chef_get_input_config()
    config = @values.dup

    new_config = {}
    json_config = {}

    config.each_pair do |key, value|
      # We only want to prefix keys we have defaults set for here (excluding recipes)
      # so that users may override cookbook attributes as well.
      if @defaults.has_key?(key) and not key.eql?(:recipes)
        json_config[key] = value
      end
    end

    new_config[:vlamp] = json_config.to_json
    new_config[:recipes] = config[:recipes]

    return new_config
  end

  def set_hostname(config)
    config[:hostname] = "#{config[:host]}.#{config[:tld]}"
    return config
  end

  def set_synced_folders(config)
    config[:sites].each_pair do |key, value|
      if value.has_key?(:host_docroot) and value.has_key?(:guest_docroot)
        config[:synced_folders][value[:host_docroot]] = value[:guest_docroot]
      end
    end

    return config
  end

  def validate_required_settings(config)
    @defaults.each_pair do |key, value|
      if not config.include?(key) or not config[key].kind_of?(value.class)
        raise ArgumentError, 'Unable to find %s %s in %s' % [type, value.class, @config_file]
      end
    end
  end
end
