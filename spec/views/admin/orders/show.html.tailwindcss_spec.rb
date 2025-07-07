require 'rails_helper'

RSpec.describe "admin/orders/show", type: :view do
  before(:each) do
    assign(:admin_order, Admin::Order.create!(
      number: "Number",
      total: "9.99",
      status: "Status",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Number/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(//)
  end
end
