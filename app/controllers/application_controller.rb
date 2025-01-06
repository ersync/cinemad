class ApplicationController < ActionController::Base




  before_action :configure_permitted_parameters, if: :devise_controller?
  def current_user
    @current_user ||= User.first
  end
  def index
    render template: 'layouts/application'
  end

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:terms, :username, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])
  end



end
