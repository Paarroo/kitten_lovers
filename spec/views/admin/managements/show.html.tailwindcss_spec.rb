require 'rails_helper'

RSpec.describe "admin/managements/show", type: :view do
  before(:each) do
    assign(:admin_management, Admin::Management.create!(
      name: "Name",
      role: "Role",
      phone: "Phone",
      email: "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Role/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
  end
end
