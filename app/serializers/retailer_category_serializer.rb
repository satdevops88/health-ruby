class RetailerCategorySerializer < ObjectSerializer
  alias_attribute :retailer_category, :object

  def serialize
    {
      full_name: retailer_category.full_name,
      id: retailer_category.id,
      name: retailer_category.name
    }
  end

end