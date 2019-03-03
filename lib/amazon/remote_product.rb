module Amazon
  class RemoteProduct
    MAX_TRIES = 3

    # TODO - return actual class object rather than struct

    def self.find_by_asin(asin)
      response = lookup(asin)

      if response
        hydrate_from_response(asin, response['ItemLookupResponse']['Items']['Item'])
      end
    end

    def self.find_items(asins: )
      response = lookup(asins.join(", "))
      items = response.dig("ItemLookupResponse", "Items", "Item")
      items = [items] if items.is_a? Hash
      items ||= []
      return items.each_with_object({}) do |item, out|
        out[item["ASIN"]] = hydrate_from_response(item["ASIN"], item)
      end
    end

    def self.hydrate_from_response(asin, item)
      # TODO - actual safety checks
      RecursiveOpenStruct.new(
        asin: asin,
        brand: item['ItemAttributes']['Brand'],
        categories: item['BrowseNodes']['BrowseNode'].is_a?(Array) ? item['BrowseNodes']['BrowseNode'].map { |node| traverse_browse_nodes(node) } : [traverse_browse_nodes(item['BrowseNodes']['BrowseNode'])],
        images: {
          thumbnail: item['SmallImage'].try(:fetch, 'URL', nil)
        },
        name: item['ItemAttributes']['Title'],
        price: item['OfferSummary']['LowestNewPrice'].try(:fetch, 'Amount', nil) ? (item['OfferSummary']['LowestNewPrice'].try(:fetch, 'Amount', nil).to_i / 100.0).to_d : nil,
        teaser: item['ItemAttributes']['Feature'].try(:first)
      )
    rescue
      nil
    end

    private

      def self.lookup(asin, try = 1)
        begin
          request.item_lookup(
            query: {
              'ItemId' => asin,
              'ResponseGroup' => 'BrowseNodes, Images, ItemAttributes, OfferSummary'
            }
          ).to_h
        rescue Excon::Error::ServiceUnavailable => e
          if try < MAX_TRIES
            sleep(try ** 2)
            lookup(asin, try + 1)
          else
            nil
          end
        end
      end

      def self.request
        return @request if defined?(@request)

        @request = Vacuum.new
        @request.associate_tag = ENV['AMAZON_AFFILIATE_TAG']
        @request
      end

      def self.traverse_browse_nodes(browse_node)
        categories = []

        while browse_node
          if browse_node['IsCategoryRoot'] != '1'
            categories << browse_node['Name']
          end

          if browse_node['Ancestors']
            browse_node = browse_node['Ancestors']['BrowseNode']
          else
            break
          end
        end

        categories.compact.reverse
      end
  end
end