class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  validates :user_id, presence: true

  # Vérifie si un item est déjà présent dans le panier
  def includes_item?(item)
    cart_items.exists?(item_id: item.id)
  end

  # Ajoute un item s'il n'est pas déjà présent
  def add_item(item)
    cart_items.create(item: item) unless includes_item?(item)
  end

  # Supprime un item du panier
  def remove_item(item)
    cart_items.find_by(item_id: item.id)&.destroy
  end

  # Calcule le prix total
  def total_price
    cart_items.includes(:item).sum { |cart_item| cart_item.item.price }
  end
end
