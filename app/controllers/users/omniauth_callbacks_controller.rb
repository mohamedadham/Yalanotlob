class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
            sign_in_and_redirect @user, evernt: :authentication
            set_flash_message(:notice, :success, kind:"google") if is_navigational_format?
        else
            session["devise.google_data"] = request.env["omniauth.auth"].expect("extra")
            redirect_to new_user_registration_url
        end
    end

    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])


        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: "facebook") if is_navigational_format?
        else
            session["devise.facebook_data"] = request.env["omniauth.auth"].except("extra")
            redirect_to new_user_registration_path
        end
    end

    def failure
        redirect_to root_path
    end
end