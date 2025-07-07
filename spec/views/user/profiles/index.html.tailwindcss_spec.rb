require 'rails_helper'

RSpec.describe "user/profiles/index", type: :view do
  before(:each) do
    assign(:user_profiles, [
      User::Profile.create!(
        first_name: "First Name",
        last_name: "Last Name",
        phone: "Phone",
        bio: "MyText"
      ),
      User::Profile.create!(
        first_name: "First Name",
        last_name: "Last Name",
        phone: "Phone",
        bio: "MyText"
      )
    ])
  end

  it "renders a list of user/profiles" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("First Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Last Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
