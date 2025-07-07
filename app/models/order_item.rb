class OrderItem < ApplicationRecord
   # === Associations ===
  belongs_to :order
  belongs_to :photo

  # === Validations ===
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :order_id, uniqueness: { scope: :photo_id, message: "already includes this photo" }
end
