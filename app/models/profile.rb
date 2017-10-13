class Profile < ApplicationRecord
  belongs_to :user

  enum degree: [ :degree_not_known,:student, :college, :university, :master ]
  enum sex: [ :sex_not_known, :man, :woman]

  do_not_validate_attachment_file_type :avatar
  has_attached_file :avatar, :default_url => "/whatever-who-cares.png"
end
