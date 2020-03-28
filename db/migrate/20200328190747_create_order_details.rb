class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.references :user, foreign_key: {on_delete: :cascade}
      t.references :order, foreign_key: {on_delete: :cascade}
      t.string :item
      t.integer :amount
      t.float :price
      t.text :comment
      t.timestamps
    end
  end
end
