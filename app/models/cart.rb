class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  validates :user_id, presence: true


  def includes_item?(item)
    cart_items.exists?(item_id: item.id)
  end
    def total_price
    cart_items.includes(:item).map do |cart_item|
      cart_item.quantity * cart_item.item.price
    end.sum
  end
  
end