require 'rails_helper'

RSpec.describe "user/orders/index", type: :view do
  before(:each) do
    assign(:user_orders, [
      User::Order.create!(
        number: "Number",
        total: "9.99",
        status: "Status"
      ),
      User::Order.create!(
        number: "Number",
        total: "9.99",
        status: "Status"
      )
    ])
  end

  it "renders a list of user/orders" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
  end
end
