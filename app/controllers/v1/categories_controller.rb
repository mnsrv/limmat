# frozen_string_literal: true

module V1
  # CategoriesController
  class CategoriesController < ApplicationController
    def create
      category = current_category_group.categories.create(category_params)

      if category.save
        render :create, locals: { category: category }, status: :created
      else
        render json: { errors: category.errors.messages },
               status: :unprocessable_entity
      end
    end

    private

    def current_category_group
      current_budget.category_groups.find(params[:category_group_id])
    end

    def category_params
      params.require(:category).permit(:name, :emoji)
    end
  end
end
