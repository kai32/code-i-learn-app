class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  
  private
  def authenticate_admin
    flash[:danger] = "Action can only be performed by admins" unless (current_user && current_user.is_admin?)
    redirect_to root_path unless (current_user && current_user.is_admin?)
  end
end
