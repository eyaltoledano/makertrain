class AddWeeklyGoalToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :weekly_goal, :integer
  end
end
