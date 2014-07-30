class DStackConfigUtils < DStackConfig
  def name()
    return 'utils'
  end

  def initialize()
    super
    @allow_extraneous_data = false
    @defaults = {
      'scripts' => {
        'post-install' => [],
        'post-up' => [],
      },
    }
  end
end
