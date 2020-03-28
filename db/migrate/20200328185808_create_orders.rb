class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: {on_delete: :cascade}
      t.string :order_for
      t.string :restaurant_name
      t.string :menu_image
      t.string :status
      t.timestamps
    end
  end
end
