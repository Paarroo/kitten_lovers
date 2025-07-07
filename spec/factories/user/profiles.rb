FactoryBot.define do
  factory :user_profile, class: 'User::Profile' do
    first_name { "MyString" }
    last_name { "MyString" }
    phone { "MyString" }
    bio { "MyText" }
  end
end
