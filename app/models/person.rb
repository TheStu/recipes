class Person < ActiveRecord::Base
  attr_accessible :age, :meal_plan_id, :name, :gender, :weight
  
  belongs_to :meal_plan
end
