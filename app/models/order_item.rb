class OrderItem < ApplicationRecord
  # === Associations ===
  belongs_to :order
  belongs_to :item
  
  # === Validations ===
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :item_id, uniqueness: { scope: :order_id, message: "is already in this order" }
end
