class CreateInstallations < ActiveRecord::Migration[5.1]
  def change
    create_table :installations do |t|
      t.string :identifier

      t.timestamps
    end
  end
end
