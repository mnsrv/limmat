# frozen_string_literal: true

# Account model
class Account < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :transactions
  belongs_to :budget

  validates :name, :on_budget, :balance, presence: true
end
