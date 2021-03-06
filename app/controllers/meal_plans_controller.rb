class MealPlansController < ApplicationController
  authorize_resource

  # GET /meal_plans
  # GET /meal_plans.json
  #def index
  #  @meal_plans = MealPlan.all

  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @meal_plans }
  #  end
  #end

  # GET /meal_plans/1
  # GET /meal_plans/1.json
  def show
    @meal_plan = MealPlan.find(params[:id])
    @meal = Meal.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meal_plan }
    end
  end

  # GET /meal_plans/new
  # GET /meal_plans/new.json
  def new
    @meal_plan = MealPlan.new
    if params[:age].present? || params[:day_type].present?
      @meal_plan.people.build(build_people(params))
      @meal_plan.days.build(build_days(params))
    else
      @meal_plan.people.build
      @meal_plan.days.build
    end

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
    num = 1
    params[:meal_plan][:days_attributes].each_value do |value|
      value['day_number'] = num
      num += 1
    end
    @meal_plan = MealPlan.new(params[:meal_plan])
    @meal_plan.user_id = current_user.id

    respond_to do |format|
      if @meal_plan.save
        format.html do
          redirect_to @meal_plan
          flash[:success] = 'Meal plan was successfully created.'
        end
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
    highest = 0
    params[:meal_plan][:days_attributes].each_value { |v| highest = v['day_number'].to_i if v['day_number'].to_i > highest }
    params[:meal_plan][:days_attributes].each_value do |value|
      if value['day_number'].blank?
        value['day_number'] = highest + 1
        highest += 1
      end
    end
    @meal_plan = MealPlan.find(params[:id])

    respond_to do |format|
      if @meal_plan.update_attributes(params[:meal_plan])
        format.html do
          redirect_to @meal_plan
          flash[:success] = 'Meal plan was successfully updated.'
        end
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
      format.html do
        redirect_to root_path
        flash[:success] = 'Meal plan was successfully deleted.'
      end
      format.json { head :no_content }
    end
  end

  private

  def modify_day_number(hash, high)
    hash.each do |k, v|
      if v.is_a? Hash
        modify_day_number(v, high)
      end
      if k == :day_number && v.blank?
        hash[k] = high + 1
        high += 1
      end
    end
  end

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
