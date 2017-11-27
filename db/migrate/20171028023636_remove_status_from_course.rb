class RemoveStatusFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :status, :boolean
  end
end
