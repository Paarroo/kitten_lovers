class CreateUserOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :user_orders do |t|
      t.string :number
      t.decimal :total
      t.string :status

      t.timestamps
    end
  end
end
