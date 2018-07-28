# frozen_string_literal: true

require 'test_helper'

module V1
  class CategoryGroupsControllerTest < ActionDispatch::IntegrationTest
    setup do
      user = users(:one)
      @budget = budgets(:usd_budget)

      @header = {
        'X-User-Email': user.email,
        'X-User-Token': user.authentication_token
      }
    end

    test 'create category group' do
      category_group_params = {
        name: Faker::Company.name
      }

      post(
        v1_category_groups_path(@budget),
        headers: @header,
        params: { category_group: category_group_params }
      )

      category_group = JSON.parse(@response.body)['data']['category_group']

      assert_response :success

      assert category_group['name'] == category_group_params[:name]
    end
  end
end
