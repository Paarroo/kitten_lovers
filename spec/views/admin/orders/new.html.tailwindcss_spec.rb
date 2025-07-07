require 'rails_helper'

RSpec.describe "admin/orders/new", type: :view do
  before(:each) do
    assign(:admin_order, Admin::Order.new(
      number: "MyString",
      total: "9.99",
      status: "MyString",
      user: nil
    ))
  end

  it "renders new admin_order form" do
    render

    assert_select "form[action=?][method=?]", admin_orders_path, "post" do

      assert_select "input[name=?]", "admin_order[number]"

      assert_select "input[name=?]", "admin_order[total]"

      assert_select "input[name=?]", "admin_order[status]"

      assert_select "input[name=?]", "admin_order[user_id]"
    end
  end
end
