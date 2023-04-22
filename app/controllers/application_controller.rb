# class ApplicationController < ActionController::Base
#   before_action :authenticate_user!

#   before_action :configure_permitted_parameters, if: :devise_controller?

#   load_and_authorize_resource

#   rescue_from CanCan::AccessDenied do | exception |
#     redirect_to root_url, alert: exception.message
#   end

#   private

#   def configure_permitted_parameters
#     default_parameters = %i[name role]
#     devise_parameter_sanitizer.permit(:sign_up, keys: default_parameters)
#     devise_parameter_sanitizer.permit(:sign_in, keys: default_parameters)
#     devise_parameter_sanitizer.permit(:account_update, keys: default_parameters)
#   end
# end

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end