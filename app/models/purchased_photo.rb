class PurchasedPhoto < ApplicationRecord
   # === Associations ===
  belongs_to :user
  belongs_to :photo

  # === Validations ===
  validates :photo_id, uniqueness: { scope: :user_id, message: "has already been purchased by this user" }
end
