class AddStripeSessionIdToOrders < ActiveRecord::Migration[8.0]
  def change
    return unless table_exists?(:orders)


    add_column :orders, :stripe_session_id, :string, null: true unless column_exists?(:orders, :stripe_session_id)


    add_index :orders, :stripe_session_id unless index_exists?(:orders, :stripe_session_id)
  end
end
