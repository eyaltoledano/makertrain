class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :status
      t.string :git_repo
      t.string :website

      t.timestamps
    end
  end
end
