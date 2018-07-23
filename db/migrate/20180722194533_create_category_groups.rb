class CreateCategoryGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :category_groups do |t|
      t.references :budget, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
