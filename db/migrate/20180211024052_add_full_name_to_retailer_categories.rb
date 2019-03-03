class AddFullNameToRetailerCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :retailer_categories, :full_name, :string
  end
end
