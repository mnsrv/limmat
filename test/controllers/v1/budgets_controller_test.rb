# frozen_string_literal: true

require 'test_helper'

module V1
  class BudgetsControllerTest < ActionDispatch::IntegrationTest
    setup do
      user = users(:one)

      @header = {
        'X-User-Email': user.email,
        'X-User-Token': user.authentication_token
      }
    end

    test 'access user budgets' do
      not_user_one_budget = budgets(:two)
      get v1_budgets_path, headers: @header

      accounts = JSON.parse(@response.body)['data']

      budget_ids = accounts.map { |account| account['id'] }

      assert_response :success
      assert_not_includes budget_ids, not_user_one_budget.id
    end

    test 'create budget for user' do
      budget_params = {
        name: Faker::Company.name,
        currency: Faker::Currency.code
      }

      post(
        v1_budgets_path,
        headers: @header,
        params: { budget: budget_params }
      )

      budget = JSON.parse(@response.body)['data']['budget']

      assert_response :success

      assert budget['name'] == budget_params[:name]
    end

    test 'get budget by id' do
      user_one_budget = budgets(:usd_budget)

      get(
        v1_budget_path(
          id: user_one_budget.id
        ),
        headers: @header
      )

      budget = JSON.parse(@response.body)['data']['budget']

      assert_response :success

      assert_equal budget['id'], user_one_budget.id
    end
  end
end
