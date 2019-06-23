class AddUserIdAndProductIdToVersions < ActiveRecord::Migration[5.0]
  def change
    add_column :versions, :user_id, :integer
    add_column :versions, :product_id, :integer
  end
end
