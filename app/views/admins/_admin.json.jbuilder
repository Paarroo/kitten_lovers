json.extract! admin, :id, :email, :first_name, :last_name, :role, :phone, :department, :active, :last_login, :permissions, :created_by, :updated_by, :created_at, :updated_at
json.url admin_url(admin, format: :json)
