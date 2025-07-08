class Avo::Resources::UserResource < Avo::BaseResource
  self.title = :email
  self.includes = [:cart, :orders, :purchased_items]
  
  def fields
    field :id, as: :id
    field :email, as: :email
    field :first_name, as: :text
    field :last_name, as: :text
    field :description, as: :textarea
    field :is_admin, as: :boolean
    field :created_at, as: :date_time
    field :updated_at, as: :date_time
  end

  def filters
    filter Avo::Filters::AdminFilter
  end

  def actions
    action Avo::Actions::PromoteToAdmin
  end
end