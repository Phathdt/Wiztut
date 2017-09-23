class User < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Association
  has_one :profile
  has_many :course_posts
  has_many :teacher_posts
  has_many :courses_as_teachers, class_name: "Course", foreign_key: "teacher_id"
  has_many :courses_as_students, class_name: "Course", foreign_key: "student_id"
  has_many :ratings, class_name: "Rating", foreign_key: "rated_id"

  has_many :conversations, :foreign_key => :sender_id
  # some scope user
  default_scope { where(active: true) }
end
