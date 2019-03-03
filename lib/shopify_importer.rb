class ShopifyImporter
  def self.do_it(file_name)
    CSV.foreach(file_name, headers: true) do |row|
      puts "READING ROW #{$.}"
      next unless row['Title'].present?

      begin
        unless Product.exists?(name: row['Title'])
          product = Product.create!(
            handle: row['Handle'],
            name: row['Title'],
            body: row['Body'],
            brand: row['Vendor'],
            product_type: row['Type'],
            image_src: row['Image Src'],
            healthiest_price: row['Variant Price'],
            option1_name: row['Option1 Name'],
            option1_value: row['Option1 Value']
          )

          if row['Tags'].present?
            row['Tags'].split(', ').each do |c|
              unless category = Category.where(name: c.downcase).first
                category = Category.create!(name: c.downcase)
              end

              ProductCategorization.create!(product: product, category: category)
            end
          end
        end
      rescue Exception => e
        puts "COULD NOT IMPORT ROW: #{$.}, #{e.message}"
      end
    end
  end
end
