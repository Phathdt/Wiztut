class ConversationPolicy < ApplicationPolicy

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    user.admin? ||
      record.sender_id == user.id ||
      record.recipient_id == user.id
  end

  def create?
    user.profile
  end

  def destroy?
    user.admin? ||
      record.sender_id == user.id ||
      record.recipient_id == user.id
  end
end
