class Rating < ApplicationRecord
  belongs_to :rater , class_name: "User", foreign_key: "rater_id"
  belongs_to :rated , class_name: "User", foreign_key: "rated_id"

  validates_uniqueness_of :rater_id, scope: [:rated_id]
  validates :rate, presence: true, inclusion: { in: 0..5 }
end
