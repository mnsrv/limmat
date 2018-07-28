json.data do
  json.category do
    json.partial!(
      'v1/categories/category',
      category: category
    )
  end
end
