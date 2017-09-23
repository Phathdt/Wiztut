class User < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Association
  has_one :profile
  has_many :course_posts
  has_many :teacher_posts
  # some scope user
  default_scope { where(active: true) }
end
