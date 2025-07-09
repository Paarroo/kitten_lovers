class CreateSolidCacheEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :solid_cache_entries do |t|
      t.string :key
      t.text :value
      t.datetime :expires_at
      # Ajoutez d'autres colonnes nécessaires ici
      t.timestamps
    end
  end
end
