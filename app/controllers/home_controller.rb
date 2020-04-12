class HomeController < ApplicationController
    def index
        @invitations= Invitation.where(:user_id => current_user.id, :status => "accepted")        
        @orders = Order.where(:user_id => current_user.id, :status =>"waiting   ")
        @activities = Invitation.where(:user_id => current_user.id, :status => "waiting").order("updated_at DESC")
    end
end
