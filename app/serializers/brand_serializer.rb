class BrandSerializer < ObjectSerializer
  alias_attribute :brand, :object

  def serialize
    {
      id: brand.id,
      name: brand.name
    }
  end

end