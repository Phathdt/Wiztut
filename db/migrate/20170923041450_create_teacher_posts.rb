class CreateTeacherPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :teacher_posts do |t|
      t.string  :title
      t.string  :grade
      t.string  :subject
      t.text    :time,    array:     true, default: []
      t.text    :address, array:     true, default: []
      t.decimal :salary,  precision: 8,    scale:   0
      t.decimal :cost
      t.text    :note
      t.integer :user_id

      t.timestamps
    end

    add_index :teacher_posts, :address, unique: true
    add_index :teacher_posts, :subject, unique: true
    add_index :teacher_posts, :grade,   unique: true
    add_index :teacher_posts, :user_id, unique: true
  end
end
