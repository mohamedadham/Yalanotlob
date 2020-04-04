class Order < ApplicationRecord
    
    belongs_to :user
    has_many :ordersDetails, :class_name => 'OrderDetail', :foreign_key => 'order_id'
    has_many :invitations, :class_name => 'Invitation', :foreign_key => 'order_id'

end
