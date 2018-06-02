class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.string :name
      t.string :currency
      t.references :owner, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
