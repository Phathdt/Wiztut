class CoursePost < ApplicationRecord
  belongs_to :users, optional: true

  def search(search_params)
    CoursePost.where(search_params)
  end
end
