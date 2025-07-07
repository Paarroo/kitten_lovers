class CreateAdmins < ActiveRecord::Migration[8.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :phone
      t.string :department
      t.boolean :active
      t.datetime :last_login
      t.text :permissions
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
    add_index :admins, :email, unique: true
    add_index :admins, :role
    add_index :admins, :active
  end
end
