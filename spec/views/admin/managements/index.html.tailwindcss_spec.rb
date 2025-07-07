require 'rails_helper'

RSpec.describe "admin/managements/index", type: :view do
  before(:each) do
    assign(:admin_managements, [
      Admin::Management.create!(
        name: "Name",
        role: "Role",
        phone: "Phone",
        email: "Email"
      ),
      Admin::Management.create!(
        name: "Name",
        role: "Role",
        phone: "Phone",
        email: "Email"
      )
    ])
  end

  it "renders a list of admin/managements" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Role".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
  end
end
