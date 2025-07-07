class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  # Pour éviter les doublons dans un panier
  validates :item_id, uniqueness: { scope: :cart_id }
end