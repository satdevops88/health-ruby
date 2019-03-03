class AddAmazonUrlToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :amazon_url, :string
  end
end
