require 'rails_helper'

RSpec.describe "admin/orders/index", type: :view do
  before(:each) do
    assign(:admin_orders, [
      Admin::Order.create!(
        number: "Number",
        total: "9.99",
        status: "Status",
        user: nil
      ),
      Admin::Order.create!(
        number: "Number",
        total: "9.99",
        status: "Status",
        user: nil
      )
    ])
  end

  it "renders a list of admin/orders" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
