class TeacherPost < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :grade, :subject, :salary, presence: true, numericality: { only_integer: true }
  validates :address, :time, presence: true

  scope :active, -> { where(status: true) }

end
