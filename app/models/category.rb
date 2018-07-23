class Category < ApplicationRecord
  belongs_to :category_group
  has_many :transactions
end
