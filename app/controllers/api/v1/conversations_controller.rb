class Api::V1::ConversationsController < Api::V1::BaseApiController

  def index
    @conversations = Conversation.involving(current_user).joins(:sender).joins(:recipient).page(params[:page])
    @current_user = current_user
    render 'conversation/index'
  end

  def show
    conversation = Conversation.find(params[:id])
    messages = conversation.messages.order( created_at: :DESC ).page(params[:page])
    authorize conversation

    render json: {
      conversation: conversation,
      messages: messages
    }, status: 200
  end

  def create
    conversation = Conversation.new(strong_params.merge({ sender_id: current_user.id}))
    authorize conversation

    if Conversation.between( current_user.id, strong_params[:recipient_id] ).present?
      conversation = Conversation.between( current_user.id, strong_params[:recipient_id] ).first
    else
      conversation.save
    end

    render json: {
      message: t('.create_conversation'), conversation: conversation
    }, status: 200

  end

  def destroy
    conversation = Conversation.find(params[:id])
    authorize conversation

    conversation.destroy
    render json: { message: t('.destroy_conversation') }, status: 200
  end

  private
  def strong_params
    params.require(:conversations).permit( :recipient_id)
  end
end
