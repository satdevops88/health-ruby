class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :amazon_id

      t.timestamps
    end
  end
end
