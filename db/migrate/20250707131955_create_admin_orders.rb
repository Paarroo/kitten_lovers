class CreateAdminOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_orders do |t|
      t.string :number
      t.decimal :total
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
