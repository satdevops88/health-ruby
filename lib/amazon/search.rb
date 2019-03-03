module Amazon
  class Search
    MAX_TRIES = 3
    TYPE_BRAND = 'Brand' # Turns out to be problematic as you can't search the All search index
    TYPE_KEYWORDS = 'Keywords'

    def initialize(term, type = TYPE_KEYWORDS)
      @term = term
      @type = type
    end

    def products
      return @products if defined?(@products)

      @products = []
      (1..5).each { |i| 
        response = search(i)
        if response
          (response.to_h['ItemSearchResponse']['Items']['Item'] || []).map { |item|
            if amazon_product = Amazon::RemoteProduct.hydrate_from_response(item['ASIN'], item)
              @products << amazon_product
            end
          }
        end
      }

      @products
    end

    def to_csv
      CSV.open(File.join(Rails.root, 'tmp', "amazon_#{@term}.csv"), 'wb') do |csv|
        csv << ['ASIN', 'Name', 'Brand', 'Amazon URL', 'Category']

        products.each do |product|
          csv << [
            product.asin,
            product.name,
            product.brand,
            "https://www.amazon.com/dp/#{product.asin}",
            product.categories.first.join(' > ')
          ]
        end
      end
    end

    private

      def search(page, try = 1)
        begin
          request.item_search(
            query: {
              @type => @term,
              'SearchIndex' => 'All',
              'ItemPage' => page,
              'ResponseGroup' => 'BrowseNodes, Images, ItemAttributes, OfferSummary'
            }
          ).to_h
        rescue Excon::Error::ServiceUnavailable => e
          if try < MAX_TRIES
            sleep(try ** 2)
            search(page, try + 1)
          else
            nil
          end
        end
      end

      def request
        return @request if defined?(@request)

        @request = Vacuum.new
        @request.associate_tag = ENV['AMAZON_AFFILIATE_TAG']
        @request
      end
  end
end