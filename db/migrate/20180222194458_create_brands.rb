class CreateBrands < ActiveRecord::Migration[5.1]
  def up
    create_table :brands do |t|
      t.string :name
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :brands, :deleted_at

    add_column :products, :brand_id, :integer
    rename_column :products, :brand, :brand_name
    add_index :products, :brand_id

    Product.reset_column_information
    brand_names = Product.with_deleted.pluck(:brand_name).uniq.compact
    brand_names.each do |brand_name|
      brand = Brand.create(name: brand_name)
      Product.with_deleted.where(brand_name: brand_name).update_all(brand_id: brand.id)
    end

    remove_column :products, :brand_name
  end

  def down
    add_column :products, :brand_name, :string
    Product.reset_column_information

    Brand.all.each do |brand|
      brand.products.update_all(brand_name: brand.name)
    end

    remove_column :products, :brand_id
    drop_table :brands
    rename_column :products, :brand_name, :brand
  end
end
