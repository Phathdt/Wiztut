class Api::V1::MessagesController < Api::V1::BaseApiController

  def create
    message = Message.new(strong_params)
    message.user_id = current_user.id
    if message.save
      render json: { message: t('.create_message') }, status: 200
    else
      render json: { message: message.errors }, status: 406
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
      render json: { message: t('.destroy_message') }, status: 200
  end

  private
  def strong_params
    params.require(:messages).permit( :body, :conversation_id)
  end
end
