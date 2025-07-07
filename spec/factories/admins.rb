FactoryBot.define do
  factory :admin do
    email { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    role { "MyString" }
    phone { "MyString" }
    department { "MyString" }
    active { false }
    last_login { "2025-07-07 10:51:59" }
    permissions { "MyText" }
    created_by { "MyString" }
    updated_by { "MyString" }
  end
end
