class Rating < ApplicationRecord
  belongs_to :user , foreign_key: "rater_id"
  belongs_to :user , foreign_key: "rated_id"
end
