class CreateGroupMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :group_members do |t|
      t.references :group, foreign_key: {on_delete: :cascade}
      t.references :user, foreign_key: {on_delete: :cascade}
    end
  end
end
