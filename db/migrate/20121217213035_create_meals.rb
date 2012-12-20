class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.integer :day_id
      t.string :recipe_title
      t.string :specific_meal
      t.integer :base_calories
      t.integer :servings_made

      t.timestamps
    end
    add_index :meals, :day_id
  end
end