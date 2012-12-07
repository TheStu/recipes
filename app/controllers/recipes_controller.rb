class RecipesController < ApplicationController
  authorize_resource
  
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.order('created_at desc')
    @selected_categories = (params[:categories].present? ? params[:categories] : [])
    #@recipes = @recipes.joins(:categories).where('categories.name IN (?)', @selected_categories) if @selected_categories.present?
    
    @recipes = @recipes.joins(:categories).where("categories.name" => @selected_categories).group('recipes.id').having('COUNT(recipes.id) = ?', @selected_categories.count)
    
    # http://stackoverflow.com/questions/9549567/finding-post-associated-with-both-of-two-categories-in-rails-3-without-custom-sq
    # http://stackoverflow.com/questions/5376869/rails-join-with-multiple-conditions
    # http://stackoverflow.com/questions/2772635/rails-find-all-with-association
    
    #Post.joins(:categories).where("categories.name" => ['catA','catB']).group('posts.id').having('COUNT(posts.id) = 2')
    
    #.where("rating IN (?)", params[:ratings]) if params[:ratings].present? and params[:ratings].any?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    @review = Review.new
    @existing_review = false
    @all_reviews = Review.where("recipe_id = ?", @recipe.id)
    if user_signed_in?
      if Review.find_by_user_id_and_recipe_id(current_user.id, @recipe.id).present?
        @existing_review = true
        @review = Review.find_by_user_id_and_recipe_id(current_user.id, @recipe.id)
      end
    end
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.json
  def new
    @recipe = Recipe.new
    3.times { @recipe.ingredients.build }
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.user_id = current_user.id
    respond_to do |format|
      if @recipe.save
        format.html do
          redirect_to @recipe
          flash[:success] = 'Recipe was successfully created.'
        end
        format.json { render json: @recipe, status: :created, location: @recipe }
      else
        format.html do
          render action: "new"
          flash[:error] = 'Oops, something went wrong.'
        end
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html do
          redirect_to @recipe
          flash[:success] = 'Recipe was successfully updated.'
        end
        format.json { head :no_content }
      else
        format.html do
          render action: "edit"
          flash[:error] = 'Oops, something went wrong.'
        end
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html do
        redirect_to root
        flash[:success] = 'Recipe successfully deleted.'
      end
      format.json { head :no_content }
    end
  end
end
