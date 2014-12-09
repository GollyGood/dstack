class DStackConfigVagrant < DStackConfig
  def name()
    return 'vagrant'
  end

  def initialize()
    super
    @allow_extraneous_data = false
    @defaults = {
      'hostname' => 'default',
      'box' => 'hashicorp/precise64',
      'networks' => {'private_network' => {:type => 'dhcp'}},
      'ipaddress' => '',
      'memory' => 2048,
      'synced_folders' => {},
      'synced_folders_type' => 'nfs',
      'tld' => 'local',
      'forward_agent' => true
    }
  end
end
