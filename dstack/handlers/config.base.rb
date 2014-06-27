class DStackConfig
  def get_value(variable, default)
    value = variable

    if value.nil?
      value = default
    end

    return value
  end
end
