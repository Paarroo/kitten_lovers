class CreatePurchasedItems < ActiveRecord::Migration[8.0]
  def change
    create_table :purchased_items do |t|
         t.references :user, null: false, foreign_key: true
         t.references :item, null: false, foreign_key: true
         t.timestamps
       end
       add_index :purchased_items, [ :user_id, :item_id ], unique: true
     end
end
