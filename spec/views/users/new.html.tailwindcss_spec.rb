require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      first_name: "MyString",
      last_name: "MyString",
      description: "MyText",
      email: "MyString",
      encrypted_password: "MyString",
      is_admin: false
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "textarea[name=?]", "user[description]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[encrypted_password]"

      assert_select "input[name=?]", "user[is_admin]"
    end
  end
end
