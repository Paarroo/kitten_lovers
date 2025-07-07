class PurchasedItem < ApplicationRecord
  belong_to :user
  belong_to :item

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :user_id, uniqueness: { scope: :item_id, message: "a déjà acheté cette photo" }
end
