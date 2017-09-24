class CreateTeacherPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :teacher_posts do |t|
      t.string  :title
      t.string  :grade
      t.string  :subject
      t.text    :time,    array:     true, default: []
      t.text    :address, array:     true, default: []
      t.decimal :salary,  precision: 8,    scale:   0
      t.text    :note
      t.integer :user_id

      t.timestamps
    end

    add_index :teacher_posts, :address
    add_index :teacher_posts, :subject
    add_index :teacher_posts, :grade
    add_index :teacher_posts, :user_id
  end
end
