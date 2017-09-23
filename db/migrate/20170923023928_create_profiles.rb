class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.date       :dob
      t.integer    :sex,            null:        false, default: 0
      t.string     :school
      t.integer    :degree,         null:        false, default: 0
      t.integer    :graduation_year
      t.text       :about_me
      t.string     :phone
      t.references :user,           foreign_key: true

      t.timestamps
    end

    add_index :profiles, :sex, unique: true
    add_index :profiles, :phone, unique: true
  end
end
