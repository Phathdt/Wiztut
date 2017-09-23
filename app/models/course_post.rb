class CoursePost < ApplicationRecord
  belongs_to :users, optional: true
end
