class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.integer :day_id
      t.integer :recipe_id
      t.string :recipe_title
      t.string :specific_meal
      t.integer :weight, :null => false, :default => 0
      t.integer :base_calories, :null => false, :default => 0
      t.integer :servings_made, :null => false, :default => 0

      t.timestamps
    end
    add_index :meals, :day_id
    add_index :meals, :recipe_id
  end
end
