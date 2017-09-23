class Course < ApplicationRecord
  belongs_to :user , foreign_key: "teacher_id"
  belongs_to :user , foreign_key: "student_id"
end
