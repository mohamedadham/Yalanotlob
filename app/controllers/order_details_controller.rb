class OrderDetailsController < ApplicationController
    def index
        @invitation = current_user.invitations.first
        @ordersDetails = OrderDetail.where(order_id: @invitation.order_id)
        return @ordersDetails
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
        # @orderDetails = Order.find(@invitation.order_id).ordersexitDetails.create(details_params)
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
