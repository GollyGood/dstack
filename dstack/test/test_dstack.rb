# dStack main testing class.
class TestDStack < Minitest::Test
  def setup
    @dstack = DStack.new(File.dirname(__FILE__) + '/assets/testing-config.dstack.yml')
  end

  def test_yaml_configs_load_from_yaml
    assert_equal 'Hash', @dstack.configs.class.name
  end
end
