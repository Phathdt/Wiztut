class CoursePost < ApplicationRecord
  belongs_to :user, optional: true
  has_many :profile, through: :user

  validates :title, presence: true
  validates :grade, :subject, :time, :address, :salary, :frequency , presence: true, numericality: { only_integer: true }

  scope :active, -> { where(status: true) }

  def search(search_params)
    CoursePost.where(search_params)
  end

  def owner
    profile.first
  end
end
