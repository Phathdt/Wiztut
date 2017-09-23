class Profile < ApplicationRecord
  belongs_to :user

  enum degree: [ :degree_not_known,:student, :college, :university, :master ]
  enum sex: [ :sex_not_known, :man, :woman]
end
