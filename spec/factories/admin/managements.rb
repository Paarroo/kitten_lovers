FactoryBot.define do
  factory :admin_management, class: 'Admin::Management' do
    name { "MyString" }
    role { "MyString" }
    phone { "MyString" }
    email { "MyString" }
  end
end
