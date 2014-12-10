# -*- mode: ruby -*-
# vi: set ft=ruby :
class DStackConfigVLAMP < DStackConfig
  def name()
    return 'vlamp'
  end

  def initialize()
    @allow_extraneous_data = false
    @defaults = {
      'sites' => {
        '<full-domain>' => {
          'guest_docroot' => '/var/www',
        },
        'full-domain' => '',
      },
      'databases' => []
    }
  end

  def values_alter_all(dstack)
    values_alter_vagrant_add_synced_folders(dstack)
    values_alter_set_full_domain(dstack)
    values_alter_process_tokens(dstack)
    values_alter_process_databases(dstack)
  end

  def values_alter_vagrant_add_synced_folders(dstack)
    vagrant = dstack.get_config('vagrant')

    @values['sites'].each_pair do |key, value|
      if value.has_key?('host_docroot') and value.has_key?('guest_docroot')
        vagrant.values['synced_folders'][value['host_docroot']] = value['guest_docroot']
      end
    end
  end

  def values_alter_set_full_domain(dstack)
    vagrant = dstack.get_config('vagrant')

    if (not vagrant['hostname'].empty? and not vagrant['tld'].empty?)
      @values['full-domain'] = "#{vagrant['hostname']}.#{vagrant['tld']}"
    end
  end

  def values_alter_process_tokens(dstack)
    tmp_configs = @values.to_json
    tmp_configs = tmp_configs.gsub '<full-domain>', @values['full-domain']
    @values = JSON.parse(tmp_configs)
  end

  def values_alter_process_databases(dstack)
    @values['databases'].map! do |database|
      # Tokens may had placed periods in the names. Since mysql doesn't support
      # periods we should replace them with underscores.
      database.sub '.', '_'
    end
  end
end
