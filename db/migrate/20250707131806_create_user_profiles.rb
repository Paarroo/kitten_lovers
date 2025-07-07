class CreateUserProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :user_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.text :bio

      t.timestamps
    end
  end
end
