class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :title
      t.text :introduction
      t.text :preperation
      t.integer :cooking_time
      t.string :equipment
      t.integer :servings
      t.string :picture
      t.integer :weight
      t.integer :calories

      t.timestamps
    end
    add_index :recipes, :cooking_time
    add_index :recipes, :weight
    add_index :recipes, :calories
    add_index :recipes, :user_id
  end
end
