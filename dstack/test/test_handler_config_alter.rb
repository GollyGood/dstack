require_relative 'helper_handler_config.rb'

class TestDStackHandlerConfigExplicit < HelperDStackConfig
  def setup()
    super
    @config_class = DStackConfigAlterTest
    @config = @dstack.get_config('testing-alterer')
  end

  def test_alterations_were_made()
    assert @dstack.get_config('testing-alteree').has_key?('altered'), 'Configuration values should be altered'
  end
end

class DStackConfigAlteree < DStackConfig
  def name()
    return 'testing-alteree'
  end
end

class DStackConfigAlterer < DStackConfig
  def name()
    return 'testing-alterer'
  end

  def values_alter_all(dstack)
    values_alter_testing_alteree(dstack.get_config('testing-alteree'))
  end

  def values_alter_testing_alteree(config)
    config.set_value('altered', true)
  end
end
