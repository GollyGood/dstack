class DStackConfigVagrant < DStackConfig
  def name()
    return 'vagrant'
  end

  def initialize()
    super
    @allow_extraneous_data = false
    @defaults = {
      'hostname' => '',
      'host' => 'default',
      'box' => 'hashicorp/precise64',
      'ipaddress' => '192.168.33.10',
      'memory' => 2048,
      'synced_folders' => {},
      'synced_folders_type' => 'nfs',
      'tld' => 'dstack',
      'forward_agent' => true
    }
  end

  def values_alter_self()
    set_hostname()
  end

  def set_hostname()
    if (@values['hostname'] == '')
      @values['hostname'] = "#{@values['host']}.#{@values['tld']}"
    end
  end
end
