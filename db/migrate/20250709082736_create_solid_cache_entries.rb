class CreateSolidCacheEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :solid_cache_entries do |t|
      t.string :key
      t.text :value
      t.datetime :expires_at
       add_column :solid_cache_entries, :key_hash, :string
      t.timestamps
    end
  end
end
