class RatingPolicy < ApplicationPolicy

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    user.courses_as_students.where(teacher_id: record.rated_id).where(status: 1).exists?
  end

  def destroy?
    user.admin? ||
      record.rater_id == user.id
  end
end
