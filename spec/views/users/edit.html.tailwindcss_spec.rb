require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      first_name: "MyString",
      last_name: "MyString",
      description: "MyText",
      email: "MyString",
      encrypted_password: "MyString",
      is_admin: false
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "textarea[name=?]", "user[description]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[encrypted_password]"

      assert_select "input[name=?]", "user[is_admin]"
    end
  end
end
