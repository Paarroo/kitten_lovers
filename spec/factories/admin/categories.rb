FactoryBot.define do
  factory :admin_category, class: 'Admin::Category' do
    name { "MyString" }
    description { "MyText" }
    active { false }
  end
end
