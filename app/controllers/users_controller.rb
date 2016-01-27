class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, except: [:follow]
  
  def index
    @users = User.all.paginate(page: params[:page], per_page: 9)
  end
  
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def follow
    followee = User.find(params[:user_id])
    # debugger
    if current_user.follow_user(followee)
      render status: 200, nothing: true
    else
      render status: 500, nothing: true
    end
  end
  
  def unfollow
    fellowship = current_user.fellowships.where(followee_id: params[:user_id]).first
    # debugger
    if fellowship.destroy
      render status: 200, nothing: true
    else
      render status: 500, nothing: true
    end
  end
  
end