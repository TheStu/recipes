class StaticsController < ApplicationController
  layout "home", :only => [:home]

  def home
    @recipes = Recipe.order('created_at desc').first(10)
  end

  def contact
  end

  def about
  end

  def privacy
  end

  def gear
    @stoves = Link.where("link_type = ?", "stove")
    @pots = Link.where("link_type = ?", "pot|pan")
    @accessories = Link.where("link_type = ?", "stove+accessory")
    @spoons = Link.where("link_type = ?", "spoon|spatula")
    @plates = Link.where("link_type = ?", "plate|bowl")
    @sporks = Link.where("link_type = ?", "spork|spoon")
    @knives = Link.where("link_type = ?", "knife")
    @mugs = Link.where("link_type = ?", "cup|mug")
    @soaps = Link.where("link_type = ?", "soap|cooking")
  end

  def calories_calculator
  end

  def results
    unless params[:gender].present? && params[:day_type].present?
      redirect_to :back
      flash[:error] = 'You need to fill in the fields for at least one person and one day for the calculator to work!'
    else
      @days = params[:day_type]
      @people = build_people(params)
    end
  end

  private

  def build_people(params)
    people = []
    params['gender'].count.times do |i|
      person = {}
      person['name'] = params['name'][i]
      person['gender'] = params['gender'][i]
      person['age'] =  params['age'][i]
      person['weight'] =  params['weight'][i]
      people << person
    end
    return people
  end
end
