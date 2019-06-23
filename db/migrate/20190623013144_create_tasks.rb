class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.string :reward
      t.string :status
      t.string :pr_link
      t.integer :user_id
      t.integer :product_id
      t.integer :version_id

      t.timestamps
    end
  end
end
