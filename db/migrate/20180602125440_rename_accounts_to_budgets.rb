class RenameAccountsToBudgets < ActiveRecord::Migration[5.2]
  def change
    rename_table :accounts, :budgets
  end
end
