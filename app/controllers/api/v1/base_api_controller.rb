class Api::V1::BaseApiController < ActionController::Base
  
  private
  def authencate_token!
    @user = User.find_by(authentication_token: params[:authentication_token])
    render json: { message: t('api.v1.base_api.user_not_found') }, status: 404 unless @user
  end

end
