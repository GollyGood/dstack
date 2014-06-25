# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'config.vlamp'

class VLAMP
  attr_accessor :config

  def load_config(config_file)
    @config = VLAMPConfig.new(config_file)
  end
end
