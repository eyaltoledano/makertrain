class AddSlugToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :slug, :string
  end
end
