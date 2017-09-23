class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer    :rater_id
      t.integer    :rated_id
      t.integer    :rate,    default: 0
      t.string     :comment
      
      t.timestamps
    end
  end
end
