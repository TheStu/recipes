class MealsController < ApplicationController

  def create
    params[:meal].delete('meal_plan_id')
    @meal = Meal.new(params[:meal])
    if @meal.save
      redirect_to :back
      flash[:success] = 'Successfully added the recipe to your meal plan.'
    else
      redirect_to :back
      flash[:error] = []
      @meal.errors.full_messages.each do |error|
        flash[:error] << error
      end
    end
  end
  
  def update
    @meal = Meal.find(params[:id])

    respond_to do |format|
      if @meal.update_attributes(params[:meal])
        format.html do
          redirect_to :back
          flash[:success] = 'Meal was successfully updated.'
        end
        format.json { head :no_content }
      else
        format.html do
          redirect_to :back
          flash[:error] = []
          @meal.errors.full_messages.each do |error|
            flash[:error] << error
          end
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    respond_to do |format|
      format.html do
        redirect_to :back
        flash[:success] = 'Meal was successfully deleted.'
      end
      format.json { head :no_content }
    end
  end
end
