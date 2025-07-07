json.extract! admin_product, :id, :name, :description, :price, :category, :stock, :created_at, :updated_at
json.url admin_product_url(admin_product, format: :json)
