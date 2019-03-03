class AddParentIdToRetailerCategories < ActiveRecord::Migration[5.1]
  def change
  	add_column :retailer_categories, :parent_id, :integer
  	add_index :retailer_categories, :parent_id
  end
end
