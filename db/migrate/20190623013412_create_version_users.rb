class CreateVersionUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :version_users do |t|
      t.integer :user_id
      t.integer :version_id
      t.timestamps
    end
  end
end
