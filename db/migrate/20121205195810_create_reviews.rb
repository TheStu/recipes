class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.text :content
      t.integer :stars

      t.timestamps
    end
  end
end
