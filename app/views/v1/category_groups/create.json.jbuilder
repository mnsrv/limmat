json.data do
  json.category_group do
    json.partial!(
      'v1/category_groups/category_group',
      category_group: category_group
    )
  end
end
