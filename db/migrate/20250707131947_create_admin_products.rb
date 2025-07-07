class CreateAdminProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :category
      t.integer :stock

      t.timestamps
    end
  end
end
