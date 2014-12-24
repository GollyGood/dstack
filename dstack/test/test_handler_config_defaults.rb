require_relative 'helper_handler_config.rb'

# Default configuration handler testing class.
class TestDStackHandlerConfigDefault < HelperDStackConfig
  def setup
    super
    @config_class = DStackConfigDefaultsTest
    @config = @dstack.get_config('testing')
  end

  def test_defaults_were_set
    assert @config['setting'] == 'default', 'Defaults should had been added to the configuration.'
  end

  def test_defaults_were_overriden
    refute @config['p2'] == 'default', 'Defaults should had been overriden by the YAML config.'
  end
end

# Default configuration handler for testing.
class DStackConfigDefaultsTest < DStackConfig
  def name
    'testing'
  end

  def initialize
    super
    @defaults = {
      'setting' => 'default',
      'p2' => 'default'
    }
  end
end
