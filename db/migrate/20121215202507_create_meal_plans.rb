class CreateMealPlans < ActiveRecord::Migration
  def change
    create_table :meal_plans do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    
    add_index :meal_plans, :user_id
  end
end
