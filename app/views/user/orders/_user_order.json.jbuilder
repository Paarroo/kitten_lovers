json.extract! user_order, :id, :number, :total, :status, :created_at, :updated_at
json.url user_order_url(user_order, format: :json)
