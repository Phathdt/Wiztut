class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  after_create :update_conversation

  def update_conversation
    conversation.update(updated_at: Time.now)
  end
end
