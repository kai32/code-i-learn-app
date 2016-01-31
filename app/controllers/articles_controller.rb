class ArticlesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :index, :recents, :featured]
  before_action :set_article, only: [:show, :edit, :update, :destroy, :toggle_feature]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.order( created_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @comment = Comment.new
    @comments = @article.comments.where(parent_id: nil).paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    if params[:is_draft] == "1"
      if @article.save_as_draft
        flash[:success] = "Saved as draft"
        redirect_to draft_articles_path and return
      else
        render 'new' and return
      end
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def toggle_feature
    if @article.toggle!(:is_featured)
      flash[:notice] = "Successfully toggled featured status of this article"
    else
      flash[:danger] = "Error toggling featured status of this article"
    end
    redirect_to article_path(@article)
  end
  
  def featured
    @articles = Article.where( is_featured: true).order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end
  
  def recents
    @articles = Article.all.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
  end
  
  def following
    @articles = Article.followed_by(current_user).paginate(page: params[:page], per_page: 5)
  end
  
  def drafts
    @drafts = current_user.article_drafts
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def edit_draft
    draft = Article.find_draft(params[:id])
    if draft.user_id != current_user.id
      flash[:danger] = "Draft can only be edited by user who created them"
      redirect_to root_path
    end
    @article= Article.from_draft(draft)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :user_id, :description,:bootsy_image_gallery_id, :draft_id,category_ids: [])
    end
end
