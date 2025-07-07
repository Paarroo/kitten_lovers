class CreateAdminUserManagements < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_user_managements do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :status

      t.timestamps
    end
  end
end
