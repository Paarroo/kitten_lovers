class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :image_url

      t.timestamps
    end
  end
end
