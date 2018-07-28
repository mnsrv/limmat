# frozen_string_literal: true

module V1
  # CategoryGroupsController
  class CategoryGroupsController < ApplicationController
    def create
      category_group = current_budget.category_groups.create(category_group_params)

      if category_group.save
        render :create, locals: { category_group: category_group }, status: :created
      else
        render json: { errors: category_group.errors.messages },
               status: :unprocessable_entity
      end
    end

    private

    def category_group_params
      params.require(:category_group).permit(:name)
    end
  end
end
