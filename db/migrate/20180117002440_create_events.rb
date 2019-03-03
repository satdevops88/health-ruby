class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :installation
      t.string :name
      t.string :categories
      t.string :external_id
      t.string :retailer
      t.references :product

      t.timestamps
    end
  end
end
