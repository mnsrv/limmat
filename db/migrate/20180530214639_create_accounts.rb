class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.boolean :on_budget
      t.boolean :closed
      t.decimal :balance
      t.references :owner, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
