class HomeController < ApplicationController
  def index
    @recent_articles = Article.all.order(:created_at)
  end
end
