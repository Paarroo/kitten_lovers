class Item < ApplicationRecord
  # === Associations ===
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :purchased_items, dependent: :destroy

  # === Validations ===
  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image_url, presence: true
end
