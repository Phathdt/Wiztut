class Rating < ApplicationRecord
  after_save :calculate_user_rate
  belongs_to :rater , class_name: "User", foreign_key: "rater_id"
  belongs_to :rated , class_name: "User", foreign_key: "rated_id"
  validates_uniqueness_of :rater_id, scope: [:rated_id]

  def calculate_user_rate
    user = self.rated
    rate = user.ratings.sum(:rate).to_f / user.ratings.count
    user.update(rate: rate)
  end
end
