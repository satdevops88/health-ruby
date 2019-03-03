class CleanupProductsColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :amazon_description
    rename_column :products, :amazon_id, :asin
    remove_column :products, :amazon_url
    rename_column :products, :body, :teaser
    change_column :products, :teaser, :string
    rename_column :products, :handle, :slug

    add_index :products, :slug, unique: true
  end
end
