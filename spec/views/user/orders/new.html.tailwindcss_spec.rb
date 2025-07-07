require 'rails_helper'

RSpec.describe "user/orders/new", type: :view do
  before(:each) do
    assign(:user_order, User::Order.new(
      number: "MyString",
      total: "9.99",
      status: "MyString"
    ))
  end

  it "renders new user_order form" do
    render

    assert_select "form[action=?][method=?]", user_orders_path, "post" do

      assert_select "input[name=?]", "user_order[number]"

      assert_select "input[name=?]", "user_order[total]"

      assert_select "input[name=?]", "user_order[status]"
    end
  end
end
