class CreateRetailers < ActiveRecord::Migration[5.1]
  def change
    create_table :retailers do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :retailers, :name, unique: true
  end
end
