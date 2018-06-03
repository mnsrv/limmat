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

    test 'should create transaction under the correct account' do
      budget = budgets(:usd_budget)
      account = budget.accounts.first

      date = Faker::Date.backward(14)
      amount = Faker::Number.decimal(2)
      memo = Faker::Company.name

      post(
        v1_account_transactions_path(
          budget_id: budget.id,
          account_id: account.id
        ),
        params: {
          transaction: {
            date: date,
            amount: amount,
            memo: memo
          }
        }
      )

      transaction = JSON.parse(@response.body)['data']['transaction']

      assert_response :success

      assert_equal date.strftime, transaction['date']
      assert_equal amount.to_f, transaction['amount']
      assert_equal memo, transaction['memo']
    end

    test 'should update transaction' do
      budget = budgets(:usd_budget)
      account = budget.accounts.first
      transaction = account.transactions.first

      amount = Faker::Number.decimal(3)

      patch(
        v1_account_transaction_path(
          budget_id: budget.id,
          account_id: account.id,
          id: transaction.id
        ),
        params: {
          transaction: {
            amount: amount
          }
        }
      )

      response_transaction = JSON.parse(@response.body)['data']['transaction']

      assert_response :success

      assert_equal amount.to_f, response_transaction['amount']
      assert_equal transaction['memo'], response_transaction['memo']
      assert_equal transaction['date'].strftime, response_transaction['date']
    end
  end
end
