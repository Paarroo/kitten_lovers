require 'rails_helper'

RSpec.describe "admin/user_managements/edit", type: :view do
  let(:admin_user_management) {
    Admin::UserManagement.create!(
      first_name: "MyString",
      last_name: "MyString",
      email: "MyString",
      phone: "MyString",
      status: "MyString"
    )
  }

  before(:each) do
    assign(:admin_user_management, admin_user_management)
  end

  it "renders the edit admin_user_management form" do
    render

    assert_select "form[action=?][method=?]", admin_user_management_path(admin_user_management), "post" do

      assert_select "input[name=?]", "admin_user_management[first_name]"

      assert_select "input[name=?]", "admin_user_management[last_name]"

      assert_select "input[name=?]", "admin_user_management[email]"

      assert_select "input[name=?]", "admin_user_management[phone]"

      assert_select "input[name=?]", "admin_user_management[status]"
    end
  end
end
