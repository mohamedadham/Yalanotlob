class ApplicationController < ActionController::Base
    
    include Devise::Controllers::Helpers
    before_action :authenticate_user!
      protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
        end
end
