class CreateRetailerProductProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :retailer_product_products do |t|
      t.references :retailer_product
      t.references :product

      t.timestamps
    end

    add_index :retailer_product_products, [:retailer_product_id, :product_id], unique: true, name: 'index_retailer_product_products_on_rp_id_and_product_id'
  end
end
