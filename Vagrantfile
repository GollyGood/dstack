# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  dlamp = DLAMP.new()
  puts(dlamp.config)

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "hashicorp/precise64"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "../docroot", "/home/vagrant/docroot", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
    vb.gui = false
# Use VBoxManage to customize the VM. For example to change memory: vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = [
      'cookbooks/berks-cookbooks',
      'cookbooks/local-cookbooks',
    ]
    #chef.add_recipe 'default-web'

    # You may also specify custom JSON attributes:
    chef.json = {}
   end
end

class DLAMP
  attr_reader :config

  def initialize()
    @config = load_config()
  end

  def load_config()
    config_file = 'config.yml'
    config = {
      :host => 'web',
      :tld => 'dlamp'
    }

    if (File.exists?(config_file) and dlamp_overrides = YAML::load_file(config_file))
      config = config.merge(dlamp_overrides)
    end

    validate_required_settings(config)
    config = set_hostname(config)

    return config
  end

  def set_hostname(config)
    config[:hostname] = "#{config[:host]}.#{config[:tld]}"
    return config
  end

  def validate_required_settings(config)
  end
end
