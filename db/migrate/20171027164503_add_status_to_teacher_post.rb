class AddStatusToTeacherPost < ActiveRecord::Migration[5.1]
  def change
    add_column :teacher_posts, :status, :boolean
  end
end
