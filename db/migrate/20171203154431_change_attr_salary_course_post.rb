class ChangeAttrSalaryCoursePost < ActiveRecord::Migration[5.1]
  def change
    change_column :course_posts, :salary, :decimal, :precision => 20, :scale => 2
  end
end
