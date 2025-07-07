require 'rails_helper'

RSpec.describe "user/profiles/new", type: :view do
  before(:each) do
    assign(:user_profile, User::Profile.new(
      first_name: "MyString",
      last_name: "MyString",
      phone: "MyString",
      bio: "MyText"
    ))
  end

  it "renders new user_profile form" do
    render

    assert_select "form[action=?][method=?]", user_profiles_path, "post" do

      assert_select "input[name=?]", "user_profile[first_name]"

      assert_select "input[name=?]", "user_profile[last_name]"

      assert_select "input[name=?]", "user_profile[phone]"

      assert_select "textarea[name=?]", "user_profile[bio]"
    end
  end
end
