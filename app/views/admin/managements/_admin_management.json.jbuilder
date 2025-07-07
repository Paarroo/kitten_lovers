json.extract! admin_management, :id, :name, :role, :phone, :email, :created_at, :updated_at
json.url admin_management_url(admin_management, format: :json)
