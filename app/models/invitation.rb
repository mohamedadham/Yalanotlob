class Invitation < ApplicationRecord

    belongs_to :user
    belongs_to :order
    after_commit :create_notifications, on: :create
    after_commit :update_notifications, on: :update

end
def create_notifications()
       Notification.create do |notification|
          notification.notify_type ='request'
          notification.actor = self.order.user
          notification.user = self.user
          notification.target = self.order
          notification.second_target = self
       end
end

def update_notifications()
    Notification.create do |notification|
        notification.notify_type ='response'
        notification.actor = self.user
        notification.user = self.order.user
        notification.target = self.order
        notification.second_target = self
    end
end