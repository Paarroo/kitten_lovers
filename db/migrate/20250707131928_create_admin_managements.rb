class CreateAdminManagements < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_managements do |t|
      t.string :name
      t.string :role
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
