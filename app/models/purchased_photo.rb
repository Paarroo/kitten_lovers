class PurchasedPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :photo
end
