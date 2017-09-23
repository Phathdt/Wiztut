class CreateCoursePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :course_posts do |t|
      t.string     :title
      t.string     :grade
      t.string     :subject
      t.integer    :time,           null:        false, default: 0
      t.integer    :address
      t.text       :real_address
      t.decimal    :salary
      t.decimal    :cost
      t.integer    :sex_require,    null:        false, default: 0
      t.integer    :degree_require, null:        false, default: 0
      t.references :user,           foreign_key: true

      t.timestamps
    end

    add_index :course_posts, :sex_require, unique: true
    add_index :course_posts, :degree_require, unique: true
    
  end
end
