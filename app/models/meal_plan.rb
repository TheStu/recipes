class MealPlan < ActiveRecord::Base
  attr_accessible :name, :total_calories, :total_days, :total_people, :user_id
  
  belongs_to :user

  has_many :people, :dependent => :destroy
  has_many :days, :dependent => :destroy
  has_many :meals, :dependent => :destroy
  
  accepts_nested_attributes_for :days
  accepts_nested_attributes_for :people
end
