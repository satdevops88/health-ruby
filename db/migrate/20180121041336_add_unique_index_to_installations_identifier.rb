class AddUniqueIndexToInstallationsIdentifier < ActiveRecord::Migration[5.1]
  def change
    add_index :installations, :identifier, unique: true
  end
end
