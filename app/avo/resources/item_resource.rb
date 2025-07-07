class Avo::Resources::ItemResource < Avo::BaseResource
  self.title = :title
  self.includes = [ :cart_items, :order_items, :purchased_items ]

  def fields
    field :id, as: :id
    field :title, as: :text, required: true
    field :description, as: :textarea, required: true
    field :price, as: :number, required: true, step: 0.01
    field :image_url, as: :url, required: true
    field :created_at, as: :date_time
    field :updated_at, as: :date_time

    field :cart_items, as: :has_many
    field :order_items, as: :has_many
    field :purchased_items, as: :has_many
  end

  def filters
    filter Avo::Filters::PriceRangeFilter
  end
end
