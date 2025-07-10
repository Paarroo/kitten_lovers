class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price, precision: 10, scale: 2
      t.string :status, default: "pending"

      t.timestamps
    end

    add_index :orders, :status
  end
end
