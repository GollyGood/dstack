require_relative 'helper_handler_config.rb'

class TestDStackHandlerConfigExplicit < HelperDStackConfig
  def setup()
    super
    @config_class = DStackConfigExplicitTest
    @config = @dstack.get_config('testing-explicit')
  end

  def test_extraenous_data_was_removed()
    refute @config.has_key?('extraneous'), 'Extraenous data should not be allowed on the Explicit class.'
  end

  def test_config_is_empty()
    assert_empty @config.values, 'Values should be empty since there are no defaults and we do not allow entraneous data'
  end
end

class DStackConfigExplicitTest < DStackConfig
  def name()
    return 'testing-explicit'
  end

  def initialize()
    super
    @allow_extraneous_data = false
  end
end
