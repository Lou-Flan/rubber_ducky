module DeviseWhitelist
  extend ActiveSupport::Concern

  included do 
    before_action :configure_permitted_parameters, if: :devise_controller?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

end

#allows custom params in the devise user setup to allow for a username