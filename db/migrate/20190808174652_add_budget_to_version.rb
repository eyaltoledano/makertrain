class AddBudgetToVersion < ActiveRecord::Migration[5.0]
  def change
    add_column :versions, :planned_budget, :integer
    add_column :versions, :available_budget, :integer
  end
end
