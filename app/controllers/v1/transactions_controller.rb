class V1::TransactionsController < ApplicationController
  def index
    @transactions = current_user.transactions

    render :index, status: :ok
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)

    @transaction.save
    render :create, status: :created
  end

  def destroy
    @transaction = current_user.transactions.where(id: params[:id]).first()
    if @transaction.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  private 

  def transaction_params
    params.require(:transaction).permit(:date, :amount, :memo)
  end
end
