class CreateTeacherPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :teacher_posts do |t|
      t.string     :title
      t.string     :grade
      t.string     :subject
      t.text       :time, array:       true,  default: []
      t.text       :address, array:       true,  default: []
      t.decimal    :salary
      t.decimal    :cost
      t.text       :note
      t.references :user,   foreign_key: true

      t.timestamps
    end

    add_index :teacher_posts, :address, unique: true
    add_index :teacher_posts, :subject, unique: true
    add_index :teacher_posts, :grade,   unique: true
  end
end
