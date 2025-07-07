require 'rails_helper'

RSpec.describe "admins/edit", type: :view do
  let(:admin) {
    Admin.create!(
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
    )
  }

  before(:each) do
    assign(:admin, admin)
  end

  it "renders the edit admin form" do
    render

    assert_select "form[action=?][method=?]", admin_path(admin), "post" do

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
