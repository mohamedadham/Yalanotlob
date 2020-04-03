class OrderDetailsController < ApplicationController
    def index
        @invitation = current_user.invitations.first
        @ordersDetails = OrderDetail.where(order_id: @invitation.order_id)
        return @ordersDetails
    end

    def show
        return @post = Post.find(params[:id]), @post.comments
    end

    def new
        index()
    end

    def create
        # p params
        p "hello"
        @invitation = current_user.invitations.first
        @orderDetails = OrderDetail.new
        @orderDetails.order_id = @invitation.order_id
        @orderDetails.user_id = current_user.id
        @orderDetails.item = params[:item]
        @orderDetails.amount = params[:amount]
        @orderDetails.price = params[:price]
        @orderDetails.comment = params[:comment]
        
        @orderDetails.save
        # @orderDetails = current_user.orderDetail.create(details_params)
        redirect_to new_order_detail_path
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to :posts
        else 
            render :edit
        end  
    end

    def destroy
        @post = Post.find(params[:id])
        @post.delete
        redirect_to :posts
    end
    private
    # def details_params
    #   params.permit(:item, :amount, :price, :comment)
    # end
    
end
