require 'rails_helper'

RSpec.describe "admin/user_managements/new", type: :view do
  before(:each) do
    assign(:admin_user_management, Admin::UserManagement.new(
      first_name: "MyString",
      last_name: "MyString",
      email: "MyString",
      phone: "MyString",
      status: "MyString"
    ))
  end

  it "renders new admin_user_management form" do
    render

    assert_select "form[action=?][method=?]", admin_user_managements_path, "post" do

      assert_select "input[name=?]", "admin_user_management[first_name]"

      assert_select "input[name=?]", "admin_user_management[last_name]"

      assert_select "input[name=?]", "admin_user_management[email]"

      assert_select "input[name=?]", "admin_user_management[phone]"

      assert_select "input[name=?]", "admin_user_management[status]"
    end
  end
end
