class CreateCoursePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :course_posts do |t|
      t.string  :title
      t.integer :grade,          null:      false, default: 0
      t.integer :subject,        null:      false, default: 0
      t.integer :time,           null:      false, default: 0
      t.integer :address
      t.text    :real_address
      t.decimal :salary,         precision: 8,     scale:   0
      t.integer :sex_require,    null:      false, default: 0
      t.integer :degree_require, null:      false, default: 0
      t.integer :user_id

      t.timestamps
    end

    add_index :course_posts, :sex_require
    add_index :course_posts, :degree_require
    add_index :course_posts, :user_id
    
  end
end
