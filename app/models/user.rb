class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :purchased_items, dependent: :destroy
  has_many :purchased_photos, through: :purchased_items, source: :item


  after_create :create_cart


  def admin?
    is_admin
  end

  def has_purchased?(item)
    purchased_items.exists?(item: item)
  end


  def already_purchased?(item)
    has_purchased?(item)
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def display_name
    full_name.present? ? full_name : email.split('@').first.humanize
  end

  private

  def create_cart
    Cart.create(user: self) if cart.nil?
  end
end
