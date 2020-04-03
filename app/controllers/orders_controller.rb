class OrdersController < ApplicationController
    def new
        
    end

    def create
        users = params['id'];
        order = Order.new;
        order.user_id = 1;
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
end
