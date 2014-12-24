require_relative 'helper_handler_config.rb'

# Configuration handler testing class.
class TestDStackHandlerConfigExplicit < HelperDStackConfig
  def setup
    super
    @config_class = DStackConfigAlterTest
    @config = @dstack.get_config('testing-alterer')
  end

  def test_alterations_were_made
    assert @dstack.get_config('testing-alteree').key?('altered'), 'Configuration values should be altered'
  end
end

# Alteree configuration handler for testing.
class DStackConfigAlteree < DStackConfig
  def name
    'testing-alteree'
  end
end

# Alterer configuration handler for testing.
class DStackConfigAlterer < DStackConfig
  def name
    'testing-alterer'
  end

  def values_alter_all(dstack)
    values_alter_testing_alteree(dstack.get_config('testing-alteree'))
  end

  def values_alter_testing_alteree(config)
    config.set_value('altered', true)
  end
end
