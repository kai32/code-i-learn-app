class CategoriesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :index, :recents, :featured]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, except: [:show, :index]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all.paginate(page: params[:page], per_page: 9)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @featured_articles = @category.articles.where(is_featured: true).order( created_at: :desc)
    @recent_articles = @category.articles.order(created_at: :desc) - @featured_articles
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def featured
    @category = Category.find(params[:category_id])
    @articles = @category.articles.where( is_featured: true).order( created_at: :desc).paginate(page: params[:page], per_page: 5)
  end
  
  def recents
    @category = Category.find(params[:category_id])
    @articles = @category.articles.order( created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def follow
    user_category = UserCategory.new(user_id: current_user.id, category_id: params[:category_id])
    if user_category.save
      render status: 200, nothing: true
    else
      render status: 500, nothing: true
    end
  end
  
  def unfollow
    user_category = UserCategory.where(user_id: current_user.id, category_id: params[:category_id]).first
    if user_category
      if user_category.destroy
        render status: 200, nothing: true
      else
        render status: 500, nothing: true
      end
    else
      render status: 404, nothing: true
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title)
    end
end
