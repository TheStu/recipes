class Recipe < ActiveRecord::Base
  attr_accessible :calories, :cooking_time, :equipment, :introduction, :picture, :preperation, :servings,
  :title, :user, :weight, :pots, :category_ids, :ingredients_attributes, :remove_picture, :average_stars

  belongs_to :user
  has_many :categories, :through => :category_joins
  has_many :category_joins, :dependent => :destroy

  has_many :ingredients, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  accepts_nested_attributes_for :category_joins
  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  validates :pots, :inclusion => { :in => ['0', '1', '2', '2+'],
    :message => "needs to be a number between 0 and 2+" }
  validates :cooking_time, :numericality => {:only_integer => true, :message => "is not a number"}
  validates :servings, :numericality => {:only_integer => true, :message => "is not a number"}
  validates :weight, :numericality => {:only_integer => true, :message => "is not a number"}
  validates :calories, :numericality => {:only_integer => true, :message => "is not a number"}
  validates :introduction, :preperation, :title, :equipment, :presence => true

  def to_param
    "#{id}-#{title.parameterize}"
  end

  mount_uploader :picture, RecipeUploader
  include PgSearch
  pg_search_scope :search, against: [:title, :introduction, :preperation, :equipment],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {ingredients: :name}

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  def self.find_with_categories(*categories)
    return [] if categories.empty?
    join_frags, condition_frags = [], []
    categories.flatten.each_with_index do |cat,i|
      join_frags << "INNER JOIN category_joins ap#{i} ON recipes.id = ap#{i}.recipe_id"
      condition_frags << "ap#{i}.category_id = #{Category.find_by_name(cat).id}"
    end
    find(:all, :readonly => false,
         :joins => join_frags.join(" "),
         :conditions => condition_frags.join(" AND "))
  end

  def related
    self.find_by_categories do |recipes|
      recipes.sort_by do |p|
        matched_categories = p.categories.find_all {|t| self.categories.include?(t)}
        matched_categories.size
      end.reverse
    end
  end

  def find_by_categories
    category_ids = self.categories.collect{|a| a.id}
    Recipe.includes(:category_joins).where(["category_joins.category_id IN (?) AND category_joins.recipe_id != ?", categories, self.id])
  end
end


