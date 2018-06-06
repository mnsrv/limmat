# frozen_string_literal: true

module V1
  # Manages the Budget model
  class BudgetsController < ApplicationController
    def index
      budgets = current_user.budgets

      render :index, locals: { budgets: budgets }
    end

    def create
      budget = current_user.budgets.build(budget_params)

      if budget.save
        render :create, status: :created, locals: { budget: budget }
      else
        head(:unprocessable_entity)
      end
    end

    def show
      budget = current_user.budgets.friendly.find(params[:id])

      if budget
        render :show, status: :ok, locals: { budget: budget }
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
      params.require(:budget).permit(:name, :currency)
    end
  end
end
