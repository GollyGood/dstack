class DStackConfigChef < DStackConfig
  def name()
    return 'chef'
  end

  def initialize()
    super
    @defaults = {
      'cookbooks_path' => [
        'cookbooks/berks-cookbooks',
        'cookbooks/local-cookbooks',
      ],
      'recipes' => [
        'default-web'
      ]
    }
  end
end
