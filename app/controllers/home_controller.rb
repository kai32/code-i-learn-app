class HomeController < ApplicationController
  skip_before_filter :authenticate_user! 
  def index
    @featured_articles = Article.where(is_featured: true).order(created_at: :desc).limit(2)
    @recent_articles = Article.all.order(created_at: :desc) - @featured_articles.limit(3)
  end
  
  def about
    
  end
end
