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
  end
end
