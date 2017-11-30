class Profile < ApplicationRecord
  belongs_to :user

  enum degree: [ :degree_not_known,:student, :college, :university, :master ]
  enum sex: [ :sex_not_known, :man, :woman]

  has_attached_file :avatar,
    default_url: "/assets/default_icon.png",
    path: ":attachment/:id/:style.:extension",
    url: ":s3_alias_url",
    s3_permissions: "public-read",
    convert_options: {all: "-background white -flatten +matte"}

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :name, :dob, :school, :phone, :grades, :subjects, presence: true
  validates :sex, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
  validates :degree, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
  validates :graduation_year, presence: true, numericality: { greater_than_or_equal_to: 1910}
  validates :salary, presence: true, numericality: { greater_than_or_equal_to: 0}
end
