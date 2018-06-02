class AddReferenceToAccountFromTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :account, index: true, foreign_key: true
    remove_reference :transactions, :user, index: true
  end
end
