class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :meal_plan_id
      t.integer :day_number
      t.string :day_type

      t.timestamps
    end
    add_index :days, :meal_plan_id
  end
end
