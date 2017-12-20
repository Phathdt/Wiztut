class TeacherPost < ApplicationRecord
  belongs_to :user
  has_many :profile, through: :user

  validates :title, :address, :time, presence: true
  validates :grade, :subject, :salary, presence: true, numericality: { only_integer: true }

  scope :active, -> { where(status: true) }
  scope :search, ->(title){ where('lower(title) like ?', "%#{title}%")}

  def owner
    profile.first
  end
end
