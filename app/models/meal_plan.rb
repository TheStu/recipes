class MealPlan < ActiveRecord::Base
  attr_accessible :name, :total_calories, :total_days, :total_people, :user_id
  
  belongs_to :user
  has_many :recipes, :through => :meal_plan_joins
  has_many :meal_plan_joins, :dependent => :destroy
end
