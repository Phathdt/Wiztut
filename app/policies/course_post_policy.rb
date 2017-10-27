class CoursePostPolicy < ApplicationPolicy

  def initialize(user, record)
    @user = user
    @record = record
  end
  
  def create?
    user.admin? || user.teacher?
  end

  def update?
    user.admin? || record.user_id == user.id
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end
end
