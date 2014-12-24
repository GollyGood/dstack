require_relative 'helper_handler_config.rb'

# Configuration handler dynamic testing class.
class TestDStackHandlerConfigDynamic < HelperDStackConfig
  def setup
    super
    @config_class = DStackConfigDynamicTest
    @config = @dstack.get_config('testing-dynamic')
  end

  def test_extraenous_data_was_included
    assert @config.key?('extraneous'), 'Extraneous data should be allowed on the Dynamic class.'
  end
end

# Dynamic configuration handler for testing.
class DStackConfigDynamicTest < DStackConfig
  def name
    'testing-dynamic'
  end
end
