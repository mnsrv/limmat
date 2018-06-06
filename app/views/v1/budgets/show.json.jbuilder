json.data do
  json.budget do
    json.partial!(
      'v1/budgets/budget',
      budget: budget
    )
  end
end
