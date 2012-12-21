class Day < ActiveRecord::Base
  attr_accessible :day_number, :day_type, :meal_plan_id
  
  belongs_to :meal_plan
  has_many :meals, :dependent => :destroy
  
  validates_presence_of :day_type
  
  default_scope order('day_number ASC')
end
