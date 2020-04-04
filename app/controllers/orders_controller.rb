class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def new
        
    end

    def create
        users = params['id'];
        order = Order.new;
        order.user_id = current_user.id;
        order.order_for = params['order_for'];
        order.restaurant_name = params['restaurant_name'];
        
        fileName = upload_image params[:order]

        if(fileName)
            order.menu_image = fileName
        end

        order.save();

        users.each { |user| order.invitations.create([{ user_id: user }]) }
        
        render :new
    end

    def index
        @invitations= Invitation.where(:user_id => current_user.id, :status => "accepted")        
        @orders = Order.where(:user_id => current_user.id)
    end

    def update
        @notice=""
        if params[:todo] == "finish"   
          @order.status="Finished"
          @notice = "Order is finsihed."
        end
        if params[:todo] == "cancel"   
          @order.status="Canceled"
          @notice = 'Order was canceled.' 
        end
        respond_to do |format|
          if @order.update(order_params)
            format.html { redirect_to "/orders",  notice: @notice }
            format.json { render :show, status: :ok, location: @order }
          else
            format.html { render :edit }
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
        end
      end

    private

        def set_order
             @order = Order.find(params[:id])
        end

        def order_params         
            params.permit(:id)            
        end
    
end
