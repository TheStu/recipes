class CreateMealPlanJoins < ActiveRecord::Migration
  def change
    create_table :meal_plan_joins do |t|
      t.integer :meal_plan_id
      t.integer :recipe_id
      t.integer :day
      t.string :meal
      t.integer :calories
      t.boolean :custom_input, :default => false

      t.timestamps
    end
    
    add_index :meal_plan_joins, :meal_plan_id
  end
end
