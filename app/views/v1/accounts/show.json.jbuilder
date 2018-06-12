json.data do
  json.account do
    json.partial! 'v1/accounts/account', account: account
    json.transactions do
      json.array! account.transactions do |transaction|
        json.partial! 'v1/transactions/transaction', transaction: transaction
      end
    end
  end
end
