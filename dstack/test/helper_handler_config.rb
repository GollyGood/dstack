require 'minitest/autorun'
require_relative '../dstack.rb'

class HelperDStackConfig < Minitest::Test
  def setup()
    if self.class.name == 'HelperDStackConfig' then return end

    @dstack = DStack.new(self.config_file)
  end

  def config_file()
    return File.dirname(__FILE__) + '/assets/testing-config.dstack.yml'
  end

  def test_object_was_created()
    if self.class.name == 'HelperDStackConfig' then return end

    assert_instance_of @config_class, @config, 'Loaded config should be the correct corresponding class.'
  end
end
