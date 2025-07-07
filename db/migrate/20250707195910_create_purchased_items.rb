class CreatePurchasedItems < ActiveRecord::Migration[8.0]
  def change
    create_table :purchased_items do |t|
      t.reference :user, null: false, foreign_key: true
      t.reference :items, null: false, foreign_key: true
      t.timestamps
    end
     add_index :purchased_items, [ :user_id, :items_id ], unique: true
  end
end
