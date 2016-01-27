class HomeController < ApplicationController
  skip_before_filter :authenticate_user! 
  def index
    @personalized_articles = Article.followed_by(current_user).paginate(page: params[:page], per_page: 10) if current_user
    @featured_articles = Article.where(is_featured: true).order(created_at: :desc).limit(2)
    @recent_articles = Article.all.order(created_at: :desc).limit(4) - @featured_articles
  end
  
  def about
    
  end
end
