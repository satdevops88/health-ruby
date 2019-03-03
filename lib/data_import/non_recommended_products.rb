require 'csv'

module DataImport
  class NonRecommendedProducts < Base
    AMAZON_URL_COLUMN_NAME = 'Amazon URL'
    ASIN_REGEX = %r{amazon.com.*/dp/(?<asin>\w{10})}

    STATUS_FAIL_ASIN = 'Fail: Unable to find ASIN in url'
    STATUS_FAIL_PRODUCT_API = 'Fail: Unable to get product data'
    STATUS_SUCCESS = 'Success'

    # Expects the input file to be a CSV with columns:
    # - Amazon URL
    # - #1
    # - #2
    # - #3
    # This is confusing as hell right now ;)
    def run(category_name)
      category = Category.find_or_create_by(name: category_name)
      retailer = Retailer.find_or_create_by(name: Retailer::RETAILER_NAME_AMAZON)
      input = CSV.read(@input, headers: true)

      input.each do |row|
        non_recommended_asin = asin_from_url(row[AMAZON_URL_COLUMN_NAME])
        recommended_asins = ['#1', '#2', '#3'].map { |col| asin_from_url(row[col]) }

        if non_recommended_asin && recommended_asins.any?
          non_recommended_product = Amazon::RemoteProduct.find_by_asin(non_recommended_asin)
          recommended_products = recommended_asins.map { |asin| Amazon::RemoteProduct.find_by_asin(asin) }.compact

          if non_recommended_product && recommended_products.any?
            # Create retailer product (the non-recommended product)
            retailer_product = RetailerProduct.find_or_create_by(retailer: retailer, healthiest_category: category, external_id: non_recommended_asin, name: non_recommended_product.name)

            # Create our recommended products and link up
            recommended_products.each { |amazon_product| 
              recommended_product = create_local_records(amazon_product)
              ProductCategory.find_or_create_by(category: category, product: recommended_product)
              if !retailer_product.recommended_products.include?(recommended_product)
                retailer_product.recommended_products << recommended_product
              end
            }
            status = STATUS_SUCCESS
          else
            status = STATUS_FAIL_PRODUCT_API
          end
        else
          status = STATUS_FAIL_ASIN
        end

        puts "#{non_recommended_asin}: #{status}"
      end
    end

    private

      def asin_from_url(url)
        if url.present? && m = url.match(ASIN_REGEX)
          m[:asin]
        else
          nil
        end
      end

      def parse_row(row)
        asin_from_url(row[AMAZON_URL_COLUMN_NAME])
      end

      def validate_file_format!(csv)
        # TODO
      end
  end
end
