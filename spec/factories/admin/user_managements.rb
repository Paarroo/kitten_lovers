FactoryBot.define do
  factory :admin_user_management, class: 'Admin::UserManagement' do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    phone { "MyString" }
    status { "MyString" }
  end
end
