FactoryBot.define do
  factory :user_order, class: 'User::Order' do
    number { "MyString" }
    total { "9.99" }
    status { "MyString" }
  end
end
