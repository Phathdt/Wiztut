class AddNoteToCoursePost < ActiveRecord::Migration[5.1]
  def change
    add_column :course_posts, :note, :text
  end
end
