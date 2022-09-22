class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[full_name username role])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[full_name username role])
  end
end
