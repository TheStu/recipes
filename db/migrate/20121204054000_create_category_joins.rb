class CreateCategoryJoins < ActiveRecord::Migration
  def change
    create_table :category_joins do |t|
      t.integer :recipe_id
      t.integer :category_id

      t.timestamps
    end
    remove_column :categories, :recipe_id
  end
end
