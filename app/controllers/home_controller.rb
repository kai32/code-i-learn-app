class HomeController < ApplicationController
  skip_before_filter :authenticate_user! 
  def index
    @featured_articles = Article.where(is_featured: true).order(:created_at)
    @recent_articles = Article.all.order(:created_at) - @featured_articles
  end
  
  def about
    
  end
end
