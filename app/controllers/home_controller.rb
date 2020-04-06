class HomeController < ApplicationController
    def index
        @invitations= Invitation.where(:user_id => current_user.id, :status => "accepted")        
        @orders = Order.where(:user_id => current_user.id, :status =>"waiting   ")
    end
end
