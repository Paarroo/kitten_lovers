class AddFieldsToAdmins < ActiveRecord::Migration[8.0]
  def change
    add_column :admins, :first_name, :string
    add_column :admins, :last_name, :string
    add_column :admins, :role, :string
    add_column :admins, :phone, :string
  end
end
