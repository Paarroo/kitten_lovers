class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :photo

  validates :cart_id, presence: true
  valdates :photo_id, presence: true
end
