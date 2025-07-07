require 'rails_helper'

RSpec.describe "admin/categories/show", type: :view do
  before(:each) do
    assign(:admin_category, Admin::Category.create!(
      name: "Name",
      description: "MyText",
      active: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
  end
end
