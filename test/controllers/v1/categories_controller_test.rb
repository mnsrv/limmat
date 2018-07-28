# frozen_string_literal: true

require 'test_helper'

module V1
  class CategoriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      user = users(:one)
      @budget = budgets(:usd_budget)

      @header = {
        'X-User-Email': user.email,
        'X-User-Token': user.authentication_token
      }
    end

    test 'create category' do
      category_group = @budget.category_groups.first

      category_params = {
        name: Faker::Company.name,
        emoji: '🤖'
      }

      post(
        v1_category_group_categories_path(
          budget_id: @budget.id,
          category_group_id: category_group.id
        ),
        headers: @header,
        params: { category: category_params }
      )

      category = JSON.parse(@response.body)['data']['category']

      assert_response :success

      assert category['name'] == category_params[:name]
      assert category['emoji'] == category_params[:emoji]
    end
  end
end
