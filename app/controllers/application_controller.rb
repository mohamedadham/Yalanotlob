class ApplicationController < ActionController::Base
    include Devise::Controllers::Helpers
    before_action :authenticate_user!
      protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
        end

        def upload_image fileData
            if(fileData != nil)
                uploaded_io = fileData[:picture];
                fileName = File.basename(uploaded_io, File.extname(uploaded_io))+''+Time.now.strftime("%6N")+''+File.extname(uploaded_io);
                File.open(Rails.root.join('public', 'uploads', fileName), 'wb') do |file|
                    file.write(uploaded_io.read)
                    return fileName
                end
                return false
            end
        end
end
