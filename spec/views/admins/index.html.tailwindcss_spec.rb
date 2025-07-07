require 'rails_helper'

RSpec.describe "admins/index", type: :view do
  before(:each) do
    assign(:admins, [
      Admin.create!(
        email: "Email",
        first_name: "First Name",
        last_name: "Last Name",
        role: "Role",
        phone: "Phone",
        department: "Department",
        active: false,
        permissions: "MyText",
        created_by: "Created By",
        updated_by: "Updated By"
      ),
      Admin.create!(
        email: "Email",
        first_name: "First Name",
        last_name: "Last Name",
        role: "Role",
        phone: "Phone",
        department: "Department",
        active: false,
        permissions: "MyText",
        created_by: "Created By",
        updated_by: "Updated By"
      )
    ])
  end

  it "renders a list of admins" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("First Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Last Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Role".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Department".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Created By".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Updated By".to_s), count: 2
  end
end
