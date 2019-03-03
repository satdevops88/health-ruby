class RetailerSerializer < ObjectSerializer
  alias_attribute :retailer, :object

  def serialize
    {
      id: retailer.id,
      name: retailer.name
    }
  end

end