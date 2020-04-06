class OrderDetailsController < ApplicationController
    def index
        @ordersDetails = OrderDetail.where(order_id: $orderId)

        @acceptedUsers = []
        Invitation.where(order_id: $orderId, status: "accepted").find_each do |invitation|
            @acceptedUsers << invitation.user 
        end        
        @waitingUsers = []
        Invitation.where(order_id: $orderId, :status => "waiting").find_each do |invitation|
            @waitingUsers << invitation.user
        end    
    
        @acceptedCount = @acceptedUsers.count
        @waitingCount = @waitingUsers.count

        return @ordersDetails, @acceptedCount, @acceptedUsers, @waitingCount, @waitingUsers
    end

    def show
        $orderId = params[:id]
        redirect_to new_order_detail_path
    end

    def new
        index()

        @orderDetails = OrderDetail.new

    end

    def create
        @orderDetails = OrderDetail.new
        @orderDetails.order_id = $orderId
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
