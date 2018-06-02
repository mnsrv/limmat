# frozen_string_literal: true

class Budget < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :accounts
  has_many :transactions, through: :accounts

  belongs_to :owner, class_name: 'User'
end
