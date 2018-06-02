class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :slug
      t.boolean :closed
      t.boolean :on_budget
      t.decimal :balance

      t.timestamps
    end
    add_index :accounts, :slug, unique: true
  end
end
