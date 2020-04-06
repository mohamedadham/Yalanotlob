class Order < ApplicationRecord
    validates :order_for, presence: true
    validates :restaurant_name, presence: true
    validates :menu_image, presence: true
    
    belongs_to :user
    has_many :ordersDetails, :class_name => 'OrderDetail', :foreign_key => 'order_id'
    has_many :invitations, :class_name => 'Invitation', :foreign_key => 'order_id'

end
