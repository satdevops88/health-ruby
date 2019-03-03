class RetailerProductSerializer < ObjectSerializer
  alias_attribute :retailer_product, :object

  def serialize
    {
      category: retailer_product.healthiest_category ? {
        id: retailer_product.healthiest_category.id,
        name: retailer_product.healthiest_category.name
      } : nil,
      external_id: retailer_product.external_id,
      id: retailer_product.id,
      name: retailer_product.name
      # TODO - recommended_productss
    }
  end

end