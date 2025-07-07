require 'rails_helper'

RSpec.describe "admin/products/show", type: :view do
  before(:each) do
    assign(:admin_product, Admin::Product.create!(
      name: "Name",
      description: "MyText",
      price: "9.99",
      category: "Category",
      stock: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/2/)
  end
end
