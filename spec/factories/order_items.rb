FactoryBot.define do
  factory :order_item do
    order { nil }
    photo { nil }
    unit_price { "9.99" }
  end
end
