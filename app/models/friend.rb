class Friend < ApplicationRecord
    
    belongs_to :sendr, :class_name => 'User', :foreign_key => 'user_id'
    belongs_to :receiver, :class_name => 'User', :foreign_key => 'friend_id'
    
end
