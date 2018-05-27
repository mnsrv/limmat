json.data do
  json.array! @transactions do |transaction|
    json.partial! 'v1/transactions/transaction', transaction: transaction
  end
end
