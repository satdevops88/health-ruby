class ProductSerializer < ObjectSerializer
  alias_attribute :product, :object

  # TODO - consider a more future-proof API design
  def serialize
    {
      affiliate_url: "https://www.amazon.com/dp/#{product.asin}?tag=#{ENV['AMAZON_AFFILIATE_TAG']}",
      asin: product.asin,
      id: product.id,
      images: {
        thumbnail_url: product.image_src
      },
      name: product.name,
      price: product.amazon_price,
      # rating: {
      #   percentage: 85,
      #   words: 'Excellent'
      # },
      teaser: product.teaser
    }
  end

end