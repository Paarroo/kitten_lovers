require 'rails_helper'

RSpec.describe "user/orders/edit", type: :view do
  let(:user_order) {
    User::Order.create!(
      number: "MyString",
      total: "9.99",
      status: "MyString"
    )
  }

  before(:each) do
    assign(:user_order, user_order)
  end

  it "renders the edit user_order form" do
    render

    assert_select "form[action=?][method=?]", user_order_path(user_order), "post" do

      assert_select "input[name=?]", "user_order[number]"

      assert_select "input[name=?]", "user_order[total]"

      assert_select "input[name=?]", "user_order[status]"
    end
  end
end
