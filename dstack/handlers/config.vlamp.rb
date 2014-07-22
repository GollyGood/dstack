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
        '<default>' => {
          'guest_docroot' => '/var/www',
        }
      },
      'databases' => []
    }
  end

  def values_alter_all(dstack)
    values_alter_vagrant_config(dstack)
  end

  def values_alter_vagrant_config(dstack)
    vagrant = dstack.get_config('vagrant')

    @values['sites'].each_pair do |key, value|
      if value.has_key?('host_docroot') and value.has_key?('guest_docroot')
        vagrant.values['synced_folders'][value['host_docroot']] = value['guest_docroot']
      end
    end
  end
end
