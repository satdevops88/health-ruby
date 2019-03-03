require 'httparty'

module EWGSkinDeep
  class ScrapeProducts
    BASE_URL = 'https://www.ewg.org'
    CATEGORY_URL_REGEX = %r{/skindeep/browse/.+}
    MAX_TRIES = 3
    PRODUCT_URL_REGEX = %r{/skindeep/product/\d+/.+/}
    SCORE_CUTOFF = 1
    SCORE_IMAGE_URL_REGEX = %r{https://static.ewg.org/skindeep/img/draw_score/score_image(?<score>\d+)__1_.png}
    SCORE_SUMMARY_REGEX = %r{EWG's rating for .* is (?<score>\d+)\.}
    VERIFIED_IMAGE_URL = 'https://static.ewg.org/skindeep/img/EWGV_SD_Mark.png'

    def run
      categories = scrape_categories

      categories.each do |category|
        products = scrape_category(category)
        category_name = category.split('/').last
        file = File.join(Rails.root, 'tmp', "ewg_#{category_name}.csv")
        CSV.open(file, 'wb') do |csv|
          csv << ['Name', 'Score', 'Amazon URL']
          products.each do |product|
            csv << [
              product[:name],
              product[:score],
              product[:url]
            ]
          end
        end
      end
    end

    def collect_csvs
      CSV.open(File.join(Rails.root, 'tmp', 'ewg_produts.csv'), 'wb') do |csv|
        csv << ['Cagtegory', 'Name', 'Score', 'Amazon URL']

        Dir[File.join(Rails.root, 'tmp', 'ewg_*.csv')].each do |file|
          category = file.match(/ewg_(?<name>.*)\.csv/)[:name].gsub('+', ' ').gsub(';;', '/')
          rows = CSV.read(file).to_a[1..-1]
          rows.each { |row| csv << [category].concat(row) } if rows
        end
      end
    end

    private

      def get_page(url, try = 1)
        page = HTTParty.get("#{BASE_URL}#{url}")

        if page.code != 200
          if try < MAX_TRIES
            sleep(try**2)
            get_page(url, try + 1)
          else
            # TODO - should catch this and log somewhere to not halt entire scrape
            raise "Failed to get page #{url}. Got code #{page.code}"
          end
        else
          Nokogiri::HTML(page)
        end
      end

      def scrape_categories
        doc = get_page('/skindeep')

        doc.css('li.menuhover .sub li a').map { |link|
          if link.attr('href').to_s.match(CATEGORY_URL_REGEX)
            link.attr('href').gsub('https://www.ewg.org', '')
          end
        }.compact
      end

      def scrape_category(url, products = [])
        puts "\n\nCATEGORY: #{url}"
        doc = get_page(url)

        # Discarding the header row, check if no products
        if doc.css('#table-browse tr')[1..-1].empty?
          return products
        else
          doc.css('#table-browse tr')[1..-1].each { |row|
            product_url = row.css('td.product_name_list a').attr('href').to_s
            score_image_url = row.css('td').last.css('img').attr('src').to_s

            if score_image_url == VERIFIED_IMAGE_URL || score_image_url.match(SCORE_IMAGE_URL_REGEX)[:score].to_i <= SCORE_CUTOFF
              if product = scrape_product(product_url)
                puts product
                products << product
              end
            # If we've reached scores 2 or greater, stop parsing
            else
              return products
            end
          }
        end

        maybe_next_link = doc.css('#click_next_number').first.css('a').last
        if maybe_next_link.try(:text) == ' Next>'
          scrape_category(maybe_next_link.attr('href').to_s, products)
        else
          products
        end
      end

      def scrape_product(url)
        return if !url.match(PRODUCT_URL_REGEX)
        doc = get_page(url)

        score = doc.css('#summary_paragraph').text.match(SCORE_SUMMARY_REGEX)[:score].to_i
        if doc.css('a#amazon-product-link').present?
          {
            name: doc.css('#righttoptitleandcats h1').text,
            score: score,
            url: doc.css('a#amazon-product-link').attr('href').to_s.split('?').first
          }
        end
      end

  end
end