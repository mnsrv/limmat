# frozen_string_literal: true

module V1
  # Transaction endpoints
  class TransactionsController < ApplicationController
    def index
      @transactions = current_scope.transactions.order(date: :desc)

      render :index, status: :ok
    end

    def create
      transaction = current_account.transactions.build(transaction_params)

      if transaction.save
        render :create, status: :created, locals: { transaction: transaction }
      else
        head(:unprocessable_entity)
      end
    end

    def update
      transaction = current_account.transactions.find(params[:id])

      if transaction.update(transaction_params)
        render :update, locals: { transaction: transaction }
      else
        head(:unprocessable_entity)
      end
    end

    def destroy
      @transaction = current_account.transactions.find(params[:id])

      if @transaction.destroy
        head(:ok)
      else
        head(:unprocessable_entity)
      end
    end

    private

    def current_scope
      params[:account_id].present? ? current_account : current_budget
    end

    def current_account
      @current_account ||=
        current_budget.accounts.friendly.find(params[:account_id])
    end

    def transaction_params
      params.require(:transaction).permit(:date, :amount, :memo, :account_id)
    end
  end
end
