class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.references :category_group, foreign_key: true
      t.string :name
      t.string :emoji

      t.timestamps
    end
  end
end
