# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

require 'faker'

puts "🧹 Cleaning database..."

PurchasedItem.destroy_all
OrderItem.destroy_all
Order.destroy_all
CartItem.destroy_all
Cart.destroy_all
Item.destroy_all
User.destroy_all

# Reset primary key sequences
%w[
  users
  items
  carts
  cart_items
  orders
  order_items
  purchased_items
].each do |table_name|
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
end

puts " Database cleaned and primary keys reset."


# --- 1. Users ---
puts "Creating users..."

admin = User.create!(
  email: "admin@chatpic.com",
  password: "password",
  is_admin: true
)

users = []
5.times do |i|
  users << User.create!(
    email: "user#{i + 1}@chatpic.com",  
    password: "password"
  )
end

puts "#{User.count} users created (1 admin, 5 regular users)"

# --- 2. Items ---
puts "Creating items from local images..."

image_paths = Dir.glob(Rails.root.join("app/assets/images/photos/*.{jpg,jpeg,png}"))

image_paths.each do |path|
  filename = File.basename(path)

  Item.create!(
    title: Faker::Creature::Cat.name,
    description: Faker::Lorem.sentence,
    price: rand(5.0..30.0).round(2),
    image_url: "photos/#{filename}"
  )
end

puts "#{Item.count} items created"

# --- 3. Carts ---
puts "Creating carts and adding items..."

users.each do |user|
  cart = Cart.create!(user: user)
  items = Item.order("RANDOM()").limit(3)
  items.each do |item|
    CartItem.create!(cart: cart, item: item)
  end
end

puts "Carts created with 3 items per user"

# --- 4. Orders & Purchased Items ---
puts "Creating orders and purchase records..."

users.each do |user|
  items = Item.order("RANDOM()").limit(2)
  total = items.sum(&:price)

  order = Order.create!(
    user: user,
    total_price: total,
    status: "completed"
  )

  items.each do |item|
    OrderItem.create!(
      order: order,
      item: item,
      price: item.price
    )

    PurchasedItem.create!(
      user: user,
      item: item
    )
  end
end

puts "Orders and purchase history created"
puts "Seed completed successfully!"

