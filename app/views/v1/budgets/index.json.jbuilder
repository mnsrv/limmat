json.data do
  json.array! budgets do |budget|
    json.partial! 'v1/budgets/budget', budget: budget
  end
end
