class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string  :name
      t.date    :dob
      t.integer :sex,            null:      false, default: 0
      t.string  :school
      t.integer :degree,         null:      false, default: 0
      t.integer :graduation_year
      t.decimal :salary,         precision: 8,     scale:   0
      t.text    :about_me
      t.string  :phone
      t.integer :user_id

      t.timestamps
    end

    add_index :profiles, :sex
    add_index :profiles, :phone
    add_index :profiles, :user_id
  end
end
