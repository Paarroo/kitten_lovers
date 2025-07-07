json.extract! admin_user_management, :id, :first_name, :last_name, :email, :phone, :status, :created_at, :updated_at
json.url admin_user_management_url(admin_user_management, format: :json)
