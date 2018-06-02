# frozen_string_literal: true

module V1
  # Manages the Budget model
  class BudgetsController < ApplicationController
    def create
      @budget = current_user.budgets.build(budget_params)

      if @budget.save
        render :create, status: :created
      else
        head(:unprocessable_entity)
      end
    end

    def update
      @budget = current_user.budgets.friendly.find(params[:id])

      if @budget.update(budget_params)
        render :update
      else
        head(:unprocessable_entity)
      end
    end

    private

    def budget_params
      params.require(:budget).permit(:name, :on_budget, :closed, :balance)
    end
  end
end
