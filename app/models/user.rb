class User < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Association
  has_one :profile
  # some scope user
  default_scope { where(active: true) }
end
