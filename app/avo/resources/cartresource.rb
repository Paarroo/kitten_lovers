class Avo::Resources::CartResource < Avo::BaseResource
  self.title = :id
  self.includes = [ :user, :cart_items, :items ]

  def fields
    field :id, as: :id
    field :user, as: :belongs_to
    field :created_at, as: :date_time
    field :updated_at, as: :date_time


    field :cart_items, as: :has_many
    field :items, as: :has_many, through: :cart_items
  end
end
