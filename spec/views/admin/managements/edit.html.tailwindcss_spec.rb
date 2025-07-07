require 'rails_helper'

RSpec.describe "admin/managements/edit", type: :view do
  let(:admin_management) {
    Admin::Management.create!(
      name: "MyString",
      role: "MyString",
      phone: "MyString",
      email: "MyString"
    )
  }

  before(:each) do
    assign(:admin_management, admin_management)
  end

  it "renders the edit admin_management form" do
    render

    assert_select "form[action=?][method=?]", admin_management_path(admin_management), "post" do

      assert_select "input[name=?]", "admin_management[name]"

      assert_select "input[name=?]", "admin_management[role]"

      assert_select "input[name=?]", "admin_management[phone]"

      assert_select "input[name=?]", "admin_management[email]"
    end
  end
end
