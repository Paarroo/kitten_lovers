require 'rails_helper'

RSpec.describe "admins/show", type: :view do
  before(:each) do
    assign(:admin, Admin.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Role/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Department/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Created By/)
    expect(rendered).to match(/Updated By/)
  end
end
