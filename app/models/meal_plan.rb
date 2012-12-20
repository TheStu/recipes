class MealPlan < ActiveRecord::Base
  attr_accessible :name, :total_calories, :total_days, :total_people, :user_id, :people_attributes,
  :days_attributes
  
  belongs_to :user

  has_many :people, :dependent => :destroy
  has_many :days, :dependent => :destroy
  
  accepts_nested_attributes_for :days, :reject_if => lambda { |a| a[:day_type].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :people, :reject_if => lambda { |a| a[:name].blank? && a[:age].blank? && a[:gender].blank? && a[:weight].blank?  }, :allow_destroy => true
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  def self.for_day_select(user_id)
    MealPlan.where("user_id = ?", user_id).map do |plan|
      [plan.name, plan.days.each_with_index.map do |d, i| 
        ["Day #{i + 1} (#{d.day_type})", d.id]
      end
      ]
    end
  end
end
