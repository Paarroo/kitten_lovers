require 'rails_helper'

RSpec.describe "admin/products/new", type: :view do
  before(:each) do
    assign(:admin_product, Admin::Product.new(
      name: "MyString",
      description: "MyText",
      price: "9.99",
      category: "MyString",
      stock: 1
    ))
  end

  it "renders new admin_product form" do
    render

    assert_select "form[action=?][method=?]", admin_products_path, "post" do

      assert_select "input[name=?]", "admin_product[name]"

      assert_select "textarea[name=?]", "admin_product[description]"

      assert_select "input[name=?]", "admin_product[price]"

      assert_select "input[name=?]", "admin_product[category]"

      assert_select "input[name=?]", "admin_product[stock]"
    end
  end
end
