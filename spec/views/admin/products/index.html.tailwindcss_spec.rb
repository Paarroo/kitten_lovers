require 'rails_helper'

RSpec.describe "admin/products/index", type: :view do
  before(:each) do
    assign(:admin_products, [
      Admin::Product.create!(
        name: "Name",
        description: "MyText",
        price: "9.99",
        category: "Category",
        stock: 2
      ),
      Admin::Product.create!(
        name: "Name",
        description: "MyText",
        price: "9.99",
        category: "Category",
        stock: 2
      )
    ])
  end

  it "renders a list of admin/products" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Category".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
