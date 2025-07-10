module ItemsHelper

  def already_in_cart?(item)
    current_user&.cart&.cart_items&.exists?(item_id: item.id)
  end
end
