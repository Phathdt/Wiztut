class AddAttrToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin,   :boolean, null: false, default: false
    add_column :users, :active,  :boolean, null: false, default: true
    add_column :users, :teacher, :boolean, null: false, default: false
  end
end
