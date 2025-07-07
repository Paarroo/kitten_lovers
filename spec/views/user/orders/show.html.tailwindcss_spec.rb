require 'rails_helper'

RSpec.describe "user/orders/show", type: :view do
  before(:each) do
    assign(:user_order, User::Order.create!(
      number: "Number",
      total: "9.99",
      status: "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Number/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Status/)
  end
end
