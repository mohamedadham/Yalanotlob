class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def new
        @order = Order.new
    end

    def create
        users = params['id'];
        groups = params['groups']

        @order = Order.new;
        @order.user_id = current_user.id;
        @order.order_for = params['order_for'];
        @order.restaurant_name = params['restaurant_name'];
        @order.status = "waiting";
        fileName = upload_image params[:order]

        if(fileName)
          @order.menu_image = fileName
        end

        if(@order.save())
          if(users != nil)
            users.each { |user| @order.invitations.create([{ user_id: user }]) }
          elsif(groups != nil)
            groups.each { |group|
              @group = Group.find(group)
              members = @group.group_members
              members.each { |member| @order.invitations.create([{ user_id: member.user_id }]) }
            }
          end

          message = "Order submitted successfully"
          type = "success"
        else
          message = "Please fill in required fields"
          type = "error"
        end
        
        redirect_to "/orders/new", :flash => { :error => message, :type => type }
    end

    def index
        @invitations= Invitation.where(:user_id => current_user.id, :status => "accepted").order('id DESC' )        
        @orders = Order.where(:user_id => current_user.id).order('id DESC' )  
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
          @order.invitations.each { |invitation| invitation.destroy }
          @order.ordersDetails.each { |orderDetails| orderDetails.destroy }
          @notice = 'Order was canceled.' 
        end
        respond_to do |format|
          if @order.update(order_params)
            format.html { redirect_to "/orders",  notice: @notice }
            format.json { render :show, status: :ok, location: @order }
          else
            format.html { redirect_to "/orders",  notice: "Can not update the order" }
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
        end
      else
        format.html { redirect_to "/orders",  notice: "Can not update the order" }
      end
      end
    def show
          @order = Order.find(params[:id])
          @invited = Invitation.find_by(order_id: params[:id], user_id: current_user.id)
          if @order.user_id != current_user.id && @invited.nil?
            flash[:error] = "You can't view current order"
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
