class CreateRetailerProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :retailer_products do |t|
      t.references :retailer
      t.references :category
      t.string :external_id
      t.string :name

      t.timestamps
    end

    add_index :retailer_products, [:retailer_id, :external_id], unique: true
  end
end
