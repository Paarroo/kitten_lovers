class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
