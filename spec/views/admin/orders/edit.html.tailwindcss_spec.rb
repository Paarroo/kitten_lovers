require 'rails_helper'

RSpec.describe "admin/orders/edit", type: :view do
  let(:admin_order) {
    Admin::Order.create!(
      number: "MyString",
      total: "9.99",
      status: "MyString",
      user: nil
    )
  }

  before(:each) do
    assign(:admin_order, admin_order)
  end

  it "renders the edit admin_order form" do
    render

    assert_select "form[action=?][method=?]", admin_order_path(admin_order), "post" do

      assert_select "input[name=?]", "admin_order[number]"

      assert_select "input[name=?]", "admin_order[total]"

      assert_select "input[name=?]", "admin_order[status]"

      assert_select "input[name=?]", "admin_order[user_id]"
    end
  end
end
