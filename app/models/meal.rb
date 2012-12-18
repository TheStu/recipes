class Meal < ActiveRecord::Base
  attr_accessible :base_calories, :day_id, :recipe_id, :recipe_title, :servings_made, :specific_meal
  
  belongs_to :day
end
