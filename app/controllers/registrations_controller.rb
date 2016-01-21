class RegistrationsController < Devise::RegistrationsController
  
  before_filter :configure_permitted_params, only: [:create]
  
  
  protected
  def configure_permitted_params
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end
  
end