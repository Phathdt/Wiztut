class User < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Association
  has_one :profile, dependent: :destroy
  has_many :course_posts, dependent: :destroy
  has_many :teacher_posts, dependent: :destroy
  has_many :courses_as_teachers, class_name: "Course", foreign_key: "teacher_id", dependent: :destroy
  has_many :courses_as_students, class_name: "Course", foreign_key: "student_id", dependent: :destroy
  has_many :ratings, class_name: "Rating", foreign_key: "rated_id", dependent: :destroy
  has_many :rateds, class_name: "Rating", foreign_key: "rater_id", dependent: :destroy
  has_many :conversations, :foreign_key => :sender_id, dependent: :destroy

  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  default_scope { where("profiles.id IS NOT NULL")}
  scope :search, -> ( name, current_user) do
    joins(:profile).where('lower(profiles.name) like ?', "%#{name}%").where.not("users.id": current_user.id)
  end
end
