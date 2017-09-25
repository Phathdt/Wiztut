class Api::V1::ConversationsController < Api::V1::BaseApiController
  before_action :authenticate_request!, except: :index
  
  def index
      
  end

  def create
    c = Conversation.new(strong_params, sender_id: current_user.id)
    if c.save
      render json: {
        message: t('.create_conversation'),
        conversation: c
      }, status: 200
    else
      render json: { message: c.errors }, status: 406
    end
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