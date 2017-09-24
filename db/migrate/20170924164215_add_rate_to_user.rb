class AddRateToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :rate, :float, precision: 5, scale: 2, default: 0
  end
end
