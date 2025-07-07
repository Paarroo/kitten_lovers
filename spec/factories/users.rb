FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    description { "MyText" }
    email { "MyString" }
    encrypted_password { "MyString" }
    is_admin { false }
  end
end
