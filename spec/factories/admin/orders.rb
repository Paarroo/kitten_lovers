FactoryBot.define do
  factory :admin_order, class: 'Admin::Order' do
    number { "MyString" }
    total { "9.99" }
    status { "MyString" }
    user { nil }
  end
end
