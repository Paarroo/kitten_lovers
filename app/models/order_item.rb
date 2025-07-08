class OrderItem < ApplicationRecord
  # === Associations ===
  belongs_to :order
  belongs_to :item
  
  # === Validations ===
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :item_id, uniqueness: { scope: :order_id, message: "a déjà été commandé" }
end
