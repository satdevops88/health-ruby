class ChangeAdminUsersToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :admin_users, :users
    add_column :users, :admin, :boolean, default: false
  end
end
