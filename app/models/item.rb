class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :purchased_items, dependent: :destroy
  has_many :buyers, through: :purchased_items, source: :user

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image_url, presence: true

  scope :purchased_by, ->(user) { joins(:purchased_items).where(purchased_items: { user: user }) }
  scope :not_purchased_by, ->(user) {
     where.not(id: PurchasedItem.where(user: user).select(:item_id))
   }
end
