require 'rails_helper'

RSpec.describe "admin/user_managements/index", type: :view do
  before(:each) do
    assign(:admin_user_managements, [
      Admin::UserManagement.create!(
        first_name: "First Name",
        last_name: "Last Name",
        email: "Email",
        phone: "Phone",
        status: "Status"
      ),
      Admin::UserManagement.create!(
        first_name: "First Name",
        last_name: "Last Name",
        email: "Email",
        phone: "Phone",
        status: "Status"
      )
    ])
  end

  it "renders a list of admin/user_managements" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("First Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Last Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
  end
end
