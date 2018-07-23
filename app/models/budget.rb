# frozen_string_literal: true

# Budget model
class Budget < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :accounts
  has_many :transactions, through: :accounts
  has_many :category_groups

  belongs_to :owner, class_name: 'User'
end
