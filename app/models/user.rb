class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

    has_many :groups, :class_name => 'Group', :foreign_key => 'user_id'
    has_many :groupMember, :class_name => 'GroupMember', :foreign_key => 'user_id'

    has_many :following, :class_name => 'Friend', :foreign_key => 'user_id'
    has_many :followers, :class_name => 'Friend', :foreign_key => 'friend_id'

    has_many :orders, :class_name => 'Order', :foreign_key => 'user_id'
    has_many :orderDetail, :class_name => 'OrderDetail', :foreign_key => 'user_id'
    has_many :invitations, :class_name => 'Invitation', :foreign_key => 'user_id'
    
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end

    def email_required?
       false
    end
end
