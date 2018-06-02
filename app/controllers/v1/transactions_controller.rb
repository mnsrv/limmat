# frozen_string_literal: true

module V1
  # Transaction endpoints
  class TransactionsController < ApplicationController
    def index
      @transactions = current_budget.transactions

      render :index, status: :ok
    end

    def create
      budget = current_budget.budget.friendly.find(params[:budget_id])
      @transaction = budget.transactions.build(transaction_params)

      @transaction.save
      render :create, status: :created
    end

    def destroy
      budget = current_budget.budget.friendly.find(params[:budget_id])
      @transaction = budget.transactions.where(id: params[:id]).first
      if @transaction.destroy
        head(:ok)
      else
        head(:unprocessable_entity)
      end
    end

    private

    def current_budget
      @budget ||= Budget.friendly.find(params[:budget_id])
      @budget
    end

    def transaction_params
      params.require(:transaction).permit(:date, :amount, :memo)
    end
  end
end
