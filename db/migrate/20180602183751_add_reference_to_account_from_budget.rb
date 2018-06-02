class AddReferenceToAccountFromBudget < ActiveRecord::Migration[5.2]
  def change
    add_reference :accounts, :budget, index: true, foreign_key: true
  end
end
