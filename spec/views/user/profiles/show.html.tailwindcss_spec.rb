require 'rails_helper'

RSpec.describe "user/profiles/show", type: :view do
  before(:each) do
    assign(:user_profile, User::Profile.create!(
      first_name: "First Name",
      last_name: "Last Name",
      phone: "Phone",
      bio: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/MyText/)
  end
end
