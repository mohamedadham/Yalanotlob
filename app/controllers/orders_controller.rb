class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def new
        @order = Order.new
    end

    def create
        users = params['id'];
        @order = Order.new;
        @order.user_id = current_user.id;
        @order.order_for = params['order_for'];
        @order.restaurant_name = params['restaurant_name'];
        
        fileName = upload_image params[:order]

        if(fileName)
            @order.menu_image = fileName
        end

        if(@order.save())
          if(users != nil)
            users.each { |user| @order.invitations.create([{ user_id: user }]) }
          end
        end
        
        message = "Order submitted successfully"
        redirect_to "/orders/new", :flash => { :error => message }
    end

    def index
        @invitations= Invitation.where(:user_id => current_user.id, :status => "accepted")        
        @orders = Order.where(:user_id => current_user.id)
    end

    def update
        @notice=""
        if @order.status == "waiting"
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
      else
        format.html { redirect_to "/orders",  notice: "Can not update the order" }
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
