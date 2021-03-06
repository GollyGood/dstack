# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'dstack/dstack.rb'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  dstack = DStack.new(File.dirname(__FILE__) + '/config.yml')
  vagrant_config = dstack.get_config('vagrant')

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = vagrant_config['box']

  if (vagrant_config.key?('box_url'))
    config.vm.box_url = vagrant_config['box_url']
  end
  if (vagrant_config.key?('box_version'))
    config.vm.box_version = vagrant_config['box_version']
  end

  config.vm.host_name = vagrant_config['hostname']

  # Create each network.
  # default is 'private_network', type: 'dhcp'
  vagrant_config['networks'].each do |network|
    type, options = network.first
    config.vm.network type.to_sym, options.inject({}){|option,(k,v)| option[k.to_sym] = v; option}
  end

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = vagrant_config['forward_agent']
  # Fix that `stdin: is not a tty warning`.
  config.ssh.shell = 'bash'

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  vagrant_config['synced_folders'].each do |synced_folder|
    config.vm.synced_folder synced_folder['host_directory'], synced_folder['guest_directory'], synced_folder['options'].inject({}){|option,(k,v)| option[k.to_sym] = v; option}
  end

  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode.
    vb.gui = false

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", vagrant_config['memory']]
  end

  config.vm.provision :shell do |shell|
    shell.inline = <<-EOH
      export DEBIAN_FRONTEND=noninteractive

      apt-get update
      apt-get install -y build-essential
      # Add support for adding PPA's
      apt-get install -y python-software-properties
    EOH
  end

  ## Enable provisioning with chef solo, specifying a cookbooks path, roles
  ## path, and data_bags path (all relative to this Vagrantfile), and adding
  ## some recipes and/or roles.
  config.vm.provision "chef_solo" do |chef|
    chef.custom_config_path = "Vagrantfile.chef"

    chef_config = dstack.get_config('chef')
    chef.cookbooks_path = chef_config['cookbooks_path']

    chef_json = dstack.chef_array()
    chef.run_list = chef_json.delete('recipes') if chef_json['recipes']
    # Pass along our settings to chef.
    # Note: We don't have to do chef.add_recipe() because we are adding them
    #       via the :recipes value in the config.
    chef.json = chef_json
  end
end
