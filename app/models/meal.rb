class Meal < ActiveRecord::Base
  attr_accessible :base_calories, :day_id, :recipe_id, :recipe_title, :servings_made, :specific_meal,
  :weight
  attr_accessor :meal_plan_id
  
  belongs_to :day
  
  validates_presence_of :recipe_title
  validates_presence_of :specific_meal
end
