require 'rails_helper'

RSpec.describe "admin/products/edit", type: :view do
  let(:admin_product) {
    Admin::Product.create!(
      name: "MyString",
      description: "MyText",
      price: "9.99",
      category: "MyString",
      stock: 1
    )
  }

  before(:each) do
    assign(:admin_product, admin_product)
  end

  it "renders the edit admin_product form" do
    render

    assert_select "form[action=?][method=?]", admin_product_path(admin_product), "post" do

      assert_select "input[name=?]", "admin_product[name]"

      assert_select "textarea[name=?]", "admin_product[description]"

      assert_select "input[name=?]", "admin_product[price]"

      assert_select "input[name=?]", "admin_product[category]"

      assert_select "input[name=?]", "admin_product[stock]"
    end
  end
end
