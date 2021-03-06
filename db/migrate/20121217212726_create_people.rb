class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :meal_plan_id
      t.string :name
      t.integer :age
      t.string :gender
      t.integer :weight

      t.timestamps
    end
    add_index :people, :meal_plan_id
  end
end
