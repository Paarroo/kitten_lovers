class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :purchased_items, dependent: :destroy
  has_many :purchased_photos, through: :purchased_items, source: :item

  after_create :create_cart

  validates :first_name, presence: true, length: { minimum: 2 }

  def admin?
    is_admin
  end

  def has_purchased?(photo)
    purchased_items.exists?(item: photo)
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def create_cart
    Cart.create(user: self) if cart.nil?
  end
end
