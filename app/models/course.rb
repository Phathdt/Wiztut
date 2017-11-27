class Course < ApplicationRecord
  belongs_to :user , foreign_key: "teacher_id"
  belongs_to :user , foreign_key: "student_id"
  validates_uniqueness_of :teacher_id, scope: [:student_id]
  enum status:  %i(waiting_brand_approval success canceled)

  scope :get_your_course, -> (user_id) {
    where("teacher_id = ? OR student_id = ?",user_id, user_id)
  }
end
