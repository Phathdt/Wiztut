class CoursePost < ApplicationRecord
  belongs_to :user, optional: true

  def search(search_params)
    CoursePost.where(search_params)
  end
end
