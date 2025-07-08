class Avo::Resources::OrderResource < Avo::BaseResource
  self.title = :id
  self.includes = [ :user, :order_items ]

  def fields
    field :id, as: :id
    field :user, as: :belongs_to
    field :total_price, as: :number, step: 0.01
    field :status, as: :select, options: {
      "pending" => "En attente",
      "completed" => "Terminée",
      "cancelled" => "Annulée"
    }
    field :created_at, as: :date_time
    field :updated_at, as: :date_time

    # Relations
    field :order_items, as: :has_many
  end

  def filters
    filter Avo::Filters::OrderStatusFilter
  end
end
