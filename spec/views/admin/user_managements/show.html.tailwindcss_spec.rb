require 'rails_helper'

RSpec.describe "admin/user_managements/show", type: :view do
  before(:each) do
    assign(:admin_user_management, Admin::UserManagement.create!(
      first_name: "First Name",
      last_name: "Last Name",
      email: "Email",
      phone: "Phone",
      status: "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Status/)
  end
end
