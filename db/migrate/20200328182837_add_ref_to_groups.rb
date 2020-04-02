class AddRefToGroups < ActiveRecord::Migration[6.0]
  def change
    add_reference :groups, :user, foreign_key: {on_delete: :cascade}
  end
end
