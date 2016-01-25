class UsersController < ApplicationController
  skip_before_filter :authenticate_user! 
  
  def index
    @users = User.all.paginate(page: params[:page], per_page: 9)
  end
  
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
end