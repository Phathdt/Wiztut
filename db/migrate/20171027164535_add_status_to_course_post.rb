class AddStatusToCoursePost < ActiveRecord::Migration[5.1]
  def change
    add_column :course_posts, :status, :boolean, default: true
    add_column :course_posts, :phone, :text
    add_column :course_posts, :frequency, :integer
  end
end
