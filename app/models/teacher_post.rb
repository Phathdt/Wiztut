class TeacherPost < ApplicationRecord
  belongs_to :user
  has_many :profile, through: :user

  validates :title, presence: true
  validates :grade, :subject, :salary, presence: true, numericality: { only_integer: true }
  validates :address, :time, presence: true

  scope :active, -> { where(status: true) }
  scope :abc, -> { profile.first }

  def owner
    profile.first
  end
end
