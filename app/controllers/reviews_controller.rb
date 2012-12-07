class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.json
  # def index
  #   @reviews = Review.all
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @reviews }
  #   end
  # end

  # GET /reviews/1
  # GET /reviews/1.json
  # def show
  #   @review = Review.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @review }
  #   end
  # end

  # GET /reviews/new
  # GET /reviews/new.json
  # def new
  #   @review = Review.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @review }
  #   end
  # end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(params[:review])
    @review.user_id = current_user.id
    respond_to do |format|
      if @review.save
        update_average(@review.recipe_id)
        format.html do
          redirect_to @review.recipe
          flash[:success] = 'Review was successfully created.'
        end
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html do
          redirect_to @review.recipe
          flash[:error] = 'Oops, something went wrong with creating your review.'
        end
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        update_average(@review.recipe_id)
        format.html do
          redirect_to @review.recipe
          flash[:success] = 'Review was successfully updated.'
        end
        format.json { head :no_content }
      else
        format.html do
          render action: "edit"
          flash[:success] = 'Oops, something went wrong.'
        end
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @org_recipe = @review.recipe
    @review.destroy
    update_average(@org_recipe.id)
    respond_to do |format|
      format.html do
        redirect_to @org_recipe
        flash[:success] = 'Review was successfully deleted.'
      end
      format.json { head :no_content }
    end
  end
  
  private
  
  def update_average(id)
    total = Review.where("recipe_id = ?", id).sum('stars')
    ratings = Review.where("recipe_id = ?", id).count
    ratings == 0 ? average = 0 : average = total / ratings.to_f
    Recipe.find(id).update_attribute(:average_stars, average)
  end
end
