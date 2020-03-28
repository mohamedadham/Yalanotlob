class User < ApplicationRecord

    has_many :groups, :class_name => 'Group', :foreign_key => 'user_id'
    has_many :groupMember, :class_name => 'GroupMember', :foreign_key => 'user_id'

    has_many :following, :class_name => 'Friend', :foreign_key => 'user_id'
    has_many :followers, :class_name => 'Friend', :foreign_key => 'friend_id'

    has_many :orders, :class_name => 'Order', :foreign_key => 'user_id'
    has_many :orderDetail, :class_name => 'OrderDetail', :foreign_key => 'user_id'
    has_many :invitations, :class_name => 'Invitation', :foreign_key => 'user_id'

end
