class DStackConfigVagrant < DStackConfig
  def name()
    return 'vagrant'
  end

  def init_with(coder)
    @host = get_value(coder['host'], 'dstack')
    @box = get_value(coder['box'], 'hashicorp/precise64')
    @ipaddress = get_value(coder['ipaddress'], '192.168.33.10')
    @memory = get_value(coder['memory'], 2048)
    @synced_folders = get_value(coder['synced_folders'], {})
    @synced_folders_type = get_value(coder['synced_folders_type'], 'nfs')
    @tld = get_value(coder['tld'], 'vlamp')
  end
end
