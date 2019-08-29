class DropVersionUsersTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :version_users
  end
end
