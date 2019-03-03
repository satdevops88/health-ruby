class CategorySerializer < ObjectSerializer
  alias_attribute :category, :object

  def serialize
    {
      id: category.id,
      name: category.name
    }
  end

end