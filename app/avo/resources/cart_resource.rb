class Avo::Resources::CartResource < Avo::BaseResource
  self.title = :id
  self.includes = [ :user, :cart_items, :items ]

  def fields
    field :id, as: :id
    field :user, as: :belongs_to
    field :cart_items, as: :has_many
    field :created_at, as: :date_time
    field :updated_at, as: :date_time
  end

  def filters
    # add filters if need
  end

  def actions
    # add action if need
  end
end
