class AddPriceAndAmazonDescriptionToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :amazon_price, :money
    add_column :products, :healthiest_price, :money
    add_column :products, :amazon_description, :text
    add_column :products, :image_src, :string
  end
end
