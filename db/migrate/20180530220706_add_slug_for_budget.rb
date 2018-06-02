class AddSlugForBudget < ActiveRecord::Migration[5.2]
  def change
    add_column :budgets, :slug, :string
    add_index :budgets, :slug, unique: true
  end
end
