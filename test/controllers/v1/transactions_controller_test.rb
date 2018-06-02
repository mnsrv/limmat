# frozen_string_literal: true

require 'test_helper'

module V1
  class TransactionsControllerTest < ActionDispatch::IntegrationTest
    test 'should get only transactions for usd_budget' do
      budget = budgets(:usd_budget)

      not_usd_budget_transaction = budgets(:two)

      get v1_transactions_path(budget_id: budget.id)

      transactions = JSON.parse(@response.body)['data']
      transaction_ids = transactions.map { |transaction| transaction['id'] }

      assert_response :success
      assert_not_includes transaction_ids, not_usd_budget_transaction.id
    end
  end
end
