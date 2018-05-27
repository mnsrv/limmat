json.data do
  json.transaction do
    json.partial! 'v1/transactions/transaction', transaction: @transaction
  end
end
