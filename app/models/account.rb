class Account < ApplicationRecord
  has_many :transactions
  belongs_to :budget
end
