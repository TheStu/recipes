class MealPlanJoin < ActiveRecord::Base
  attr_accessible :calories, :custom_input, :day, :meal, :meal_plan_id, :recipe_id
  
  belongs_to :meal_plans
  belongs_to :recipes
end
