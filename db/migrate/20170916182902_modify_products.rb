class ModifyProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :handle, :string
    add_column :products, :body, :text
    add_column :products, :brand, :string
    add_column :products, :product_type, :string
    add_column :products, :option1_name, :string
    add_column :products, :option1_value, :string
    add_index :products, :name
  end
end
