class DStackConfigVagrant < DStackConfig
  def initialize()
    super
    @allow_extraneous_data = false
    @defaults = {
      'host' => 'dstack',
      'box' => 'hashicorp/precise64',
      'ipaddress' => '192.168.33.10',
      'memory' => 2048,
      'synced_folders' => {},
      'synced_folders_type' => 'nfs',
      'tld' => 'vlamp',
      'forward_agent' => true
    }
  end

  def name()
    return 'vagrant'
  end
end
