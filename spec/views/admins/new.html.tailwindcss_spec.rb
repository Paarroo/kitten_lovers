require 'rails_helper'

RSpec.describe "admins/new", type: :view do
  before(:each) do
    assign(:admin, Admin.new(
      email: "MyString",
      first_name: "MyString",
      last_name: "MyString",
      role: "MyString",
      phone: "MyString",
      department: "MyString",
      active: false,
      permissions: "MyText",
      created_by: "MyString",
      updated_by: "MyString"
    ))
  end

  it "renders new admin form" do
    render

    assert_select "form[action=?][method=?]", admins_path, "post" do

      assert_select "input[name=?]", "admin[email]"

      assert_select "input[name=?]", "admin[first_name]"

      assert_select "input[name=?]", "admin[last_name]"

      assert_select "input[name=?]", "admin[role]"

      assert_select "input[name=?]", "admin[phone]"

      assert_select "input[name=?]", "admin[department]"

      assert_select "input[name=?]", "admin[active]"

      assert_select "textarea[name=?]", "admin[permissions]"

      assert_select "input[name=?]", "admin[created_by]"

      assert_select "input[name=?]", "admin[updated_by]"
    end
  end
end
