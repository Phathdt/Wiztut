class Profile < ApplicationRecord
  belongs_to :user

  enum degree: [ :student, :college, :university, :master ]
  enum sex: [ :man, :woman]
end
