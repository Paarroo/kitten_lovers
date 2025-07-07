require 'rails_helper'

RSpec.describe "user/profiles/edit", type: :view do
  let(:user_profile) {
    User::Profile.create!(
      first_name: "MyString",
      last_name: "MyString",
      phone: "MyString",
      bio: "MyText"
    )
  }

  before(:each) do
    assign(:user_profile, user_profile)
  end

  it "renders the edit user_profile form" do
    render

    assert_select "form[action=?][method=?]", user_profile_path(user_profile), "post" do

      assert_select "input[name=?]", "user_profile[first_name]"

      assert_select "input[name=?]", "user_profile[last_name]"

      assert_select "input[name=?]", "user_profile[phone]"

      assert_select "textarea[name=?]", "user_profile[bio]"
    end
  end
end
