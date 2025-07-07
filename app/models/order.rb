class Order < ApplicationRecord
  # === Associations ===
  belongs_to :user
  has_many :order_items, dependent: :destroy

  # === Validations ===
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
end
