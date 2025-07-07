FactoryBot.define do
  factory :admin_product, class: 'Admin::Product' do
    name { "MyString" }
    description { "MyText" }
    price { "9.99" }
    category { "MyString" }
    stock { 1 }
  end
end
