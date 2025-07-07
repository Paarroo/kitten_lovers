json.extract! admin_order, :id, :number, :total, :status, :user_id, :created_at, :updated_at
json.url admin_order_url(admin_order, format: :json)
