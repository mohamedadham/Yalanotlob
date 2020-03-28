class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.references :user, foreign_key: {on_delete: :cascade}
      t.references :order, foreign_key: {on_delete: :cascade}
      t.string :status
      t.timestamps
    end
  end
end
