class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.date :date
      t.float :amount
      t.string :memo
      t.timestamps
    end
  end
end
