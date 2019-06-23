class RemoveUserIdFromUsersAndAddUserIdToProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :user_id
    add_column :products, :user_id, :integer
  end
end
