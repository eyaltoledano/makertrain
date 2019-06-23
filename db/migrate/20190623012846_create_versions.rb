class CreateVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :versions do |t|
      t.string :version_number
      t.string :description
      t.string :progress
      t.date :release_date

      t.timestamps
    end
  end
end
