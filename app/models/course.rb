class Course < ApplicationRecord
  belongs_to :user , foreign_key: "teacher_id"
  belongs_to :user , foreign_key: "student_id"

  scope :get_your_course, -> (user_id) {
    where("teacher_id = ? OR student_id = ?",user_id, user_id)
  }
end
