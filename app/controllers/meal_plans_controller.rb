class MealPlansController < ApplicationController
  # GET /meal_plans
  # GET /meal_plans.json
  def index
    @meal_plans = MealPlan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meal_plans }
    end
  end

  # GET /meal_plans/1
  # GET /meal_plans/1.json
  def show
    @meal_plan = MealPlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meal_plan }
    end
  end

  # GET /meal_plans/new
  # GET /meal_plans/new.json
  def new
    @meal_plan = MealPlan.new
    if params[:meal_plan].present? && params[:meal_plan] == 'yes'
      @meal_plan.people.build(build_people(params))
      @meal_plan.days.build(build_days(params))
    else
      @meal_plan.people.build
      @meal_plan.days.build
    end
    @people = build_people(params)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meal_plan }
    end
  end

  # GET /meal_plans/1/edit
  def edit
    @meal_plan = MealPlan.find(params[:id])
  end

  # POST /meal_plans
  # POST /meal_plans.json
  def create
    @meal_plan = MealPlan.new(params[:meal_plan])

    respond_to do |format|
      if @meal_plan.save
        format.html { redirect_to @meal_plan, notice: 'Meal plan was successfully created.' }
        format.json { render json: @meal_plan, status: :created, location: @meal_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meal_plans/1
  # PUT /meal_plans/1.json
  def update
    @meal_plan = MealPlan.find(params[:id])

    respond_to do |format|
      if @meal_plan.update_attributes(params[:meal_plan])
        format.html { redirect_to @meal_plan, notice: 'Meal plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meal_plans/1
  # DELETE /meal_plans/1.json
  def destroy
    @meal_plan = MealPlan.find(params[:id])
    @meal_plan.destroy

    respond_to do |format|
      format.html { redirect_to meal_plans_url }
      format.json { head :no_content }
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
  
  def build_days(params)
    days = []
    params['day_type'].count.times do |i|
      day = {}
      day['day_type'] = params['day_type'][i]
      days << day
    end
    return days
  end
end
