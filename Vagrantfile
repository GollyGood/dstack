# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'vlamp/vlamp'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  vlamp = VLAMP.new()

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = vlamp.config[:vlamp_box]

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: vlamp.config[:vlamp_ipaddress]

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  vlamp.config[:vlamp_synced_folders].each_pair do |host, guest|
    config.vm.synced_folder host, guest, type: vlamp.config[:vlamp_synced_folders_type]
  end

  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode.
    vb.gui = false

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", vlamp.config[:vlamp_memory]]
  end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = [
      'cookbooks/berks-cookbooks',
      'cookbooks/local-cookbooks',
    ]

    # Pass along our settings to chef.
    # Note: We don't have to do chef.add_recipe() because we are adding them
    #       via the :recipes value in the config.
    chef.json = vlamp.config
   end
end
