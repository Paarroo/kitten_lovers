require 'rails_helper'

RSpec.describe "admin/managements/new", type: :view do
  before(:each) do
    assign(:admin_management, Admin::Management.new(
      name: "MyString",
      role: "MyString",
      phone: "MyString",
      email: "MyString"
    ))
  end

  it "renders new admin_management form" do
    render

    assert_select "form[action=?][method=?]", admin_managements_path, "post" do

      assert_select "input[name=?]", "admin_management[name]"

      assert_select "input[name=?]", "admin_management[role]"

      assert_select "input[name=?]", "admin_management[phone]"

      assert_select "input[name=?]", "admin_management[email]"
    end
  end
end
