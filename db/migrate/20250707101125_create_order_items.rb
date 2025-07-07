class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true
      t.decimal :unit_price

      t.timestamps
    end

    add_index :order_items, [:order_id, :photo_id], unique: true
  end
end
