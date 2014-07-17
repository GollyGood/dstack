require_relative 'helper_handler_config.rb'

class TestDStackHandlerConfigDynamic < HelperDStackConfig
  def setup()
    super
    @config_class = DStackConfigDynamicTest
    @config = @dstack.get_config('testing-dynamic')
  end

  def test_extraenous_data_was_included()
    assert @config.has_key?('extraneous'), 'Extraneous data should be allowed on the Dynamic class.'
  end
end

class DStackConfigDynamicTest < DStackConfig
  def name()
    return 'testing-dynamic'
  end
end
