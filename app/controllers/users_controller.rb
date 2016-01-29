class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, except: [:follow]
  before_action :validate_is_user, only: [:followings]
  
  def index
    @users = User.all.paginate(page: params[:page], per_page: 9)
  end
  
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "Deleted user and all its articles"
      redirect_to users_path
    else
      flash[:danger] = "Error deleting user"
      redirect_to users_path
    end
  end
  
  def followers
    @followers = User.find(params[:user_id]).followers
    respond_to do |format|
      format.js
    end
  end
  
  def followings
    @followees = User.find(params[:user_id]).followees
    respond_to do |format|
      format.js
    end
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
  
  private 
  def validate_is_user
    if current_user.id.to_s != params[:user_id]
      flash[:danger] = "You can only view who you are following"
      redirect_to root_path
    end
  end
  
end