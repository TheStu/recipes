class Person < ActiveRecord::Base
  attr_accessible :age, :meal_plan_id, :name, :gender, :weight
  
  belongs_to :meal_plan
  
  validates_presence_of :age
  validates_presence_of :gender
  validates_presence_of :weight
  validates_presence_of :name
end
