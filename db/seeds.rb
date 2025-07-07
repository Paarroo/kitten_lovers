# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "🧹 Cleaning database..."
User.destroy_all
Photo.destroy_all
Cart.destroy_all
Order.destroy_all
OrderItem.destroy_all
CartItem.destroy_all
PurchasedPhoto.destroy_all

puts "✅ Database cleaned."

# --- 1. Users ---
puts "👤 Creating users..."

admin = User.create!(
  email: "admin@chatpic.com",
  password: "password",
  is_admin: true
)

users = 5.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    is_admin: false
  )
end

puts "✅ #{User.count} users created (including 1 admin)"

# --- 2. Photos based on image files ---
puts "📸 Creating photos from local image files..."

# Get list of image files inside app/assets/images/photos/
photo_image_paths = Dir.glob(Rails.root.join("app/assets/images/photos/*.{jpg,jpeg,png}"))

photo_image_paths.each do |full_path|
  filename = File.basename(full_path)

  Photo.create!(
    title: Faker::Creature::Cat.name,
    description: Faker::Lorem.sentence,
    price: rand(5.0..30.0).round(2),
    image_url: "photos/#{filename}"
  )
end

puts "✅ #{Photo.count} photos created using files in assets/images/photos/"

# --- 3. Carts with items ---
puts "🛒 Creating carts and adding items..."

users.each do |user|
  cart = Cart.create!(user: user)
  photos = Photo.order("RANDOM()").limit(3)
  photos.each do |photo|
    CartItem.create!(cart: cart, photo: photo)
  end
end

puts "✅ Carts created for each user with 3 items"

# --- 4. Orders and purchase records ---
puts "💳 Creating orders and purchase records..."

users.each do |user|
  photos = Photo.order("RANDOM()").limit(2)
  total_price = photos.sum(&:price)

  order = Order.create!(
    user: user,
    total_price: total_price,
    status: "completed"
  )

  photos.each do |photo|
    OrderItem.create!(
      order: order,
      photo: photo,
      unit_price: photo.price
    )

    PurchasedPhoto.create!(
      user: user,
      photo: photo
    )
  end
end

puts "✅ Orders and purchased photos created for each user"

puts "🎉 Seed completed successfully!"
