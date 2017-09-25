class Api::V1::ConversationsController < Api::V1::BaseApiController

  def index
    conversations = Conversation.involving(current_user).page(params[:page])
    render json: { conversations: conversations}, status: 200
  end

  def show
    conversation = Conversation.find(params[:id])
    messages = conversation.messages

    render json: {
      conversation: conversation,
      messages: messages
    }, status: 200
  end

  def create
    if Conversation.between(strong_params[:sender_id],strong_params[:recipient_id]).present?
      conversation = Conversation.between(strong_params[:sender_id],strong_params[:recipient_id]).first
    else
      conversation = Conversation.create!(strong_params)
    end

    render json: {
      message: t('.create_conversation'), conversation: conversation
    }, status: 200

  end

  def destroy
    c = Conversation.find(params[:id])
    c.destroy
    render json: { message: t('.destroy_conversation') }, status: 200
  end

  private
  def strong_params
    params.require(:conversations).permit( :sender_id, :recipient_id)
  end
end
