class RenameProductCategorizations < ActiveRecord::Migration[5.1]
  def change
    rename_table :product_categorizations, :product_categories
  end
end
