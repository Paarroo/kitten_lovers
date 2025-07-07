class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.text :description
      t.string :email
      t.string :encrypted_password
      t.boolean :is_admin

      t.timestamps
    end
  end
end
