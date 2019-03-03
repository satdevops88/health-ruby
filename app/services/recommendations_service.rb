class RecommendationsService
  MAX_RECOMMENDATIONS = 3

  def initialize(categories:, external_id:, retailer:)
    @categories = categories
    @external_id = external_id
    @retailer = Retailer.find_by(name: retailer)
  end

  def products
    return @products if defined?(@products)

    if retailer_product && retailer_product.recommended_products.any?
      @products = retailer_product.recommended_products.first(MAX_RECOMMENDATIONS)
    elsif retailer_product && retailer_product.healthiest_category
      @products = retailer_product.healthiest_category.products.first(MAX_RECOMMENDATIONS)
    elsif retailer_category
      @products = recommended_products
    else
      @products = []
    end

    Rails.logger.debug "RETAILER CATEGORY: #{retailer_category}"
    Rails.logger.debug "OUR CATEGORY(IES): #{Category.where(id: healthiest_category_ids).map(&:name)}"
    Rails.logger.debug "CATEGORY PRODUCTS: #{@products.size}"

    @products
  end

  def retailer_category_name
    if retailer_product && retailer_product.healthiest_category
      retailer_product.healthiest_category.name
    else
      retailer_category.try(:name)
    end
  end

  def retailer_product_is_recommended?
    # TODO - will need updates when we expand beyond Amazon
    Product.exists?(asin: @external_id)
  end

  private

    def healthiest_category_ids
      if retailer_category && retailer_category.category_id
        [retailer_category.category_id]
      elsif retailer_category
        retailer_category.all_descendants.map(&:category_id).compact
      else
        []
      end
    end

    def recommended_products
      Product.joins(:categories)
        .where.not(image_src: nil)
        .where(product_categories: {
          category_id: healthiest_category_ids
        }).limit(MAX_RECOMMENDATIONS)
    end

    def retailer_category
      @retailer_category ||= RetailerCategory.fuzzy_find_from_tree(categories: @categories, retailer: @retailer)
    end

    def retailer_product
      @retailer_product ||= RetailerProduct.find_by(external_id: @external_id, retailer: @retailer)
    end

end