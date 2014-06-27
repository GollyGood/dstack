require 'minitest/autorun'
require_relative '../dstack.rb'

class TestDStack < Minitest::Test
  def setup()
    @dstack = DStack.new()
    @config_file = File.dirname(__FILE__) + '/../../example-config.dstack.yml'
  end

  def test_yaml_config_load_from_yaml()
    assert_equal 'Hash', @dstack.load_yaml_config_from_file(@config_file).class.name
  end
end

class TestDStackVagrant < TestDStack
  def setup()
    super
    @documents = @dstack.load_yaml_config_from_file(@config_file)
  end

  def test_object_was_created()
    assert_equal 'DStackConfigVagrant', @dstack.get_config('vagrant').class.name
  end

  def test_values()
    config = @dstack.get_config('vagrant')
    puts config.inspect
  end
end

class TestDStackChef < TestDStack
  def setup()
    super
    @documents = @dstack.load_yaml_config_from_file(@config_file)
  end

  def test_object_was_created()
    assert_equal 'DStackConfigChef', @dstack.get_config('chef').class.name
  end

  def test_values()
    config = @dstack.get_config('chef')
    puts config.inspect
  end
end

class TestDStackVLAMP < TestDStack
  def setup()
    super
    @documents = @dstack.load_yaml_config_from_file(@config_file)
  end

  def test_object_was_created()
    assert_equal 'DStackConfigVLAMP', @dstack.get_config('vlamp').class.name
  end
end
