class RegistrationsController < Devise::RegistrationsController
  
  before_filter :configure_permitted_params, only: [:create, :update]
  
  def upload_avatar
    @user = current_user
  end
  
  def set_avatar
    @user = current_user
    if params[:user] && params[:user][:avatar]
      @user.avatar = params[:user][:avatar]
    else
      @user.errors.add(:avatar, 'No file uploaded')
      render :upload_avatar and return
    end
    if @user.save
      redirect_to upload_profile_pic_path
    else
      puts @user.errors.full_messages
      render :upload_avatar
      
    end
  end
  
  protected
  def configure_permitted_params
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :bio
  end
  
end