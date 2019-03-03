class CreateRetailerCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :retailer_categories do |t|
      t.references :category
      t.references :retailer
      t.string :name, null: false

      t.timestamps
    end
  end
end
