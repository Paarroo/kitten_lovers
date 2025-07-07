class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :purchased_items, dependent: :destroy
   has_many :purchased_photos, through: :purchased_items, source: :photo

  def admin?
    is_admin
  end

  def has_purchased?(photo)
     purchased_items.exists?(photo: photo)
   end
end
