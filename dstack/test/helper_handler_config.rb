require 'minitest/autorun'
require_relative '../dstack.rb'

# Helper testing class for dStack.
class HelperDStackConfig < Minitest::Test
  def setup
    return if self.class.name == 'HelperDStackConfig'

    @dstack = DStack.new(config_file)
  end

  def config_file
    File.dirname(__FILE__) + '/assets/testing-config.dstack.yml'
  end

  def test_object_was_created
    return if self.class.name == 'HelperDStackConfig'

    assert_instance_of @config_class, @config, 'Loaded config should be the correct corresponding class.'
  end
end
