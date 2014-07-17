class DStackConfig < Object
  class << self
    attr_reader :children

    def inherited(klass)
      @children << klass
    end
  end
  @children = []

  attr_reader :values

  def initialize()
    @values = {}
    @defaults = {}
    @allow_extraneous_data = true
  end

  def values_load(values)
    @values = @defaults

    values.each_pair do |key, value|
      if @allow_extraneous_data or @defaults.has_key?(key)
        @values[key] = value
      end
    end

    return @values
  end

  def values_alter_self()
    return @values
  end

  def values_alter_all(dstack)
  end

  def [](key)
    @values[key]
  end

  def has_key?(key)
    return @values.has_key?(key)
  end

  def to_json
    return @values.to_json
  end

  def set_value(key, value)
    return @values[key] = value
  end
end
