class OrderDetail < ApplicationRecord
    validates :item, :amount, :price, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 1 }
    validates :amount, numericality: { only_integer: true , greater_than_or_equal_to: 1}
    validates :comment, length: { maximum: 50 }
    belongs_to :user
    belongs_to :order

end
