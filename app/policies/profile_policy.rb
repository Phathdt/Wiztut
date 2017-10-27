class ProfilePolicy < ApplicationPolicy

  def initialize(user, record)
    @user = user
    @record = record
  end

  def update?
    user.admin? || record.user_id == user.id
  end
end
