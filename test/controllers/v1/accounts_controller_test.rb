# frozen_string_literal: true

require 'test_helper'

module V1
  class AccountsControllerTest < ActionDispatch::IntegrationTest
    setup do
      user = users(:one)
      @budget = budgets(:usd_budget)

      @header = {
        'X-User-Email': user.email,
        'X-User-Token': user.authentication_token
      }
    end

    test 'list out accounts for @budget' do
      account_one = accounts(:one)
      account_two = accounts(:two)

      get v1_accounts_path(@budget)

      account_ids = JSON.parse(@response.body)['data'].map do |acc|
        acc['id']
      end

      assert_response :success
      assert_includes account_ids, account_one.id
      assert_not_includes account_ids, account_two.id
    end

    test 'create account for user' do
      account_params = {
        name: Faker::Company.name,
        on_budget: true,
        balance: 0
      }

      post(
        v1_accounts_path(@budget),
        headers: @header,
        params: { account: account_params }
      )

      account = JSON.parse(@response.body)['data']['account']

      assert_response :success

      assert account['name'] == account_params[:name]
    end

    test 'should return unprocessable entity' do
      account_params = {
        name: Faker::Company.name,
        on_budget: '',
        balance: ''
      }

      post(
        v1_accounts_path(@budget),
        headers: @header,
        params: { account: account_params }
      )

      assert_response :unprocessable_entity
    end

    test 'get account by id' do
      user_one_budget = budgets(:usd_budget)
      user_one_account = accounts(:one)

      get(
        v1_account_path(
          budget_id: user_one_budget.id,
          id: user_one_account.id
        ),
        headers: @header
      )

      account = JSON.parse(@response.body)['data']['account']

      assert_response :success

      assert_equal account['id'], user_one_account.id
    end
  end
end
