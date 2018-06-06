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
  end
end
