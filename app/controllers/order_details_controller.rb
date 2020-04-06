class OrderDetailsController < ApplicationController
    def index
        @invitation = current_user.invitations.first
        @ordersDetails = OrderDetail.where(order_id: @invitation.order_id)

        @acceptedUsers = []
        Invitation.where(order_id: @invitation.order_id, status: "accepted").find_each do |invitation|
            @acceptedUsers << invitation.user 
        end        
        @waitingUsers = []
        Invitation.where(order_id: @invitation.order_id, :status => "waiting").find_each do |invitation|
            @waitingUsers << invitation.user
        end    

        @acceptedCount = @acceptedUser.count
        @waitingCount = @waitingUser.count

        return @ordersDetails, @acceptedCount, @acceptedUser, @waitingCount, @waitingUser
    end

    def show
        p params
    end

    def new
        index()
        @orderDetails = OrderDetail.new

    end

    def create
        @invitation = current_user.invitations.first
        @orderDetails = OrderDetail.new
        @orderDetails.order_id = @invitation.order_id
        @orderDetails.user_id = current_user.id
        @orderDetails.item = params[:order_detail][:item]
        @orderDetails.amount = params[:order_detail][:amount]
        @orderDetails.price = params[:order_detail][:price]
        @orderDetails.comment = params[:order_detail][:comment]
 
        @orderDetails.save
        index()
        render :new 
    end

    def destroy
        @orderDetails = OrderDetail.find(params[:id])
        @orderDetails.delete
        redirect_to new_order_detail_path
    end

    private
    def details_params
      params.require(:order_detail).permit(:item, :amount, :price, :comment)
    end
    
end
