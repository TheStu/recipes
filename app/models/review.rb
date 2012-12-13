class Review < ActiveRecord::Base
  attr_accessible :content, :stars, :recipe_id
  
  belongs_to :user
  belongs_to :recipe
  
  validates_numericality_of :stars, :minimum => 1, :message => "can't be blank"
  validates :content, :presence => true
end
