require 'csv'

module DataImport
  class RecommendedProducts < Base
    AMAZON_URL_COLUMN_NAME = 'Amazon URL'
    ASIN_REGEX = %r{amazon.com.*/dp/(?<asin>\w{10})}

    STATUS_FAIL_ASIN = 'Fail: Unable to find ASIN in url'
    STATUS_FAIL_PRODUCT_API = 'Fail: Unable to get product data'
    STATUS_SUCCESS = 'Success'

    # Expects the input file to be a CSV with columns:
    #  - Amazon URL
    def run
      input = CSV.read(@input, headers: true)
      validate_file_format!(input)

      CSV.open(File.join(Rails.root, 'tmp', "data_import_amazon_#{DateTime.current.strftime('%Y%m%d')}.csv"), 'wb') do |csv|
        csv << (input[0].to_a + ['Status']) # Pass through headers

        input.each do |row|
          asin = parse_row(row)
          if asin
            if Product.exists?(asin: asin)
              status = STATUS_SUCCESS
            else
              product = Amazon::RemoteProduct.find_by_asin(asin)

              if product
                create_local_records(product)
                status = STATUS_SUCCESS
              else
                status = STATUS_FAIL_PRODUCT_API
              end
            end
          else
            status = STATUS_FAIL_ASIN
          end

          puts "#{asin}: #{status}"
          csv << (row.to_a + [status])
        end
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
