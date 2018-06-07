# frozen_string_literal: true

module V1
  # AccountsController
  class AccountsController < ApplicationController
    def index
      accounts = current_budget.accounts

      render :index, locals: { accounts: accounts }, status: :ok
    end

    def create
      account = current_budget.accounts.create(account_params)

      if account.save
        render :create, locals: { account: account }, status: :created
      else
        render json: { errors: account.errors.messages },
               status: :unprocessable_entity
      end
    end

    private

    def account_params
      params.require(:account).permit(:name, :on_budget, :balance)
    end
  end
end
