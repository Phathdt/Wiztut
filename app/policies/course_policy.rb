class CoursePolicy < ApplicationPolicy

  def initialize(user, record)
    @user = user
    @record = record
  end

  def update?
    user.admin? || record.teacher_id == user.id
  end

  def destroy?
    user.admin? || record.teacher_id == user.id
  end
end
