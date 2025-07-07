class CreatePurchasedPhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :purchased_photos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true

      t.timestamps
    end

    add_index :purchased_photos, [:user_id, :photo_id], unique: true
  end
end
