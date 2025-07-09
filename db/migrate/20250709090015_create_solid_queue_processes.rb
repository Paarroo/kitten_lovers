class CreateSolidQueueProcesses < ActiveRecord::Migration[6.1]
  def change
    create_table :solid_queue_processes do |t|
      t.string :name
      t.integer :pid
      t.datetime :started_at
      t.datetime :heartbeat_at
      t.timestamps
    end
  end
end
